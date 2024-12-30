import os
import requests
import dropbox
from dropbox.exceptions import ApiError, AuthError
from datetime import datetime, timezone, timedelta
import logging
from pathlib import Path
import time
import hashlib
import json
import re
from dropbox import Dropbox
from dropbox.oauth import DropboxOAuth2FlowNoRedirect
import logging.handlers
from tenacity import retry, stop_after_attempt, wait_exponential

# Add log rotation to prevent large log files
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.handlers.RotatingFileHandler(
            'backup.log',
            maxBytes=1024*1024,  # 1MB
            backupCount=5
        ),
        logging.StreamHandler()  # Also log to console
    ]
)
logger = logging.getLogger(__name__)

class BackupMetrics:
    def __init__(self):
        self.start_time = time.time()
        self.total_bytes_downloaded = 0  # Only count bytes actually downloaded
        self.files_copied = 0  # Files copied from previous backup
        self.files_downloaded = 0  # Files downloaded from blob
        self.failed_uploads = 0
        self.skipped_items = 0
        self.deleted_backups = 0

    def get_summary(self):
        duration = time.time() - self.start_time
        return {
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "duration_seconds": round(duration, 2),
            "files": {
                "copied_from_previous": self.files_copied,
                "downloaded_from_blob": self.files_downloaded,
                "failed": self.failed_uploads,
                "skipped": self.skipped_items
            },
            "data_transfer": {
                "bytes_downloaded": self.total_bytes_downloaded,
                "average_speed_mbps": round((self.total_bytes_downloaded * 8) / (duration * 1_000_000), 2) if duration > 0 else 0
            },
            "cleanup": {
                "backups_deleted": self.deleted_backups
            }
        }

def cleanup_old_backups(dbx, metrics, retention_days=30):
    """Delete backups older than the specified retention period."""
    try:
        logger.info(f"Starting cleanup of backups older than {retention_days} days...")
        
        # Calculate cutoff date
        cutoff_date = datetime.now(timezone.utc) - timedelta(days=retention_days)
        
        # List all folders in the root directory
        result = dbx.files_list_folder('')
        
        # Pattern to match backup folders and extract their date
        backup_pattern = re.compile(r'vercel_blob_backup_(\d{8})_(\d{6})')
        
        for entry in result.entries:
            if not isinstance(entry, dropbox.files.FolderMetadata):
                continue
                
            match = backup_pattern.match(entry.name)
            if not match:
                continue
            
            try:
                # Parse the date from the folder name
                folder_date_str = f"{match.group(1)}_{match.group(2)}"
                folder_date = datetime.strptime(folder_date_str, '%Y%m%d_%H%M%S')
                folder_date = folder_date.replace(tzinfo=timezone.utc)
                
                # Check if this backup is older than our retention period
                if folder_date < cutoff_date:
                    logger.info(f"Deleting old backup: {entry.name} (from {folder_date.date()})")
                    dbx.files_delete_v2(entry.path_display)
                    metrics.deleted_backups += 1
                    
            except ValueError as e:
                logger.warning(f"Could not parse date from folder name {entry.name}: {e}")
            except dropbox.exceptions.ApiError as e:
                logger.error(f"Failed to delete old backup {entry.name}: {e}")
                
        logger.info(f"Cleanup completed. Deleted {metrics.deleted_backups} old backups.")
        
    except Exception as e:
        logger.error(f"Error during backup cleanup: {str(e)}")
        raise

def ping_heartbeat(status="success", extra_params=None):
    """Ping the heartbeat URL with optional status and parameters."""
    try:
        heartbeat_url = os.environ.get('HEARTBEAT_URL')
        if heartbeat_url:
            url = f"{heartbeat_url}/fail" if status == "fail" else heartbeat_url
            if extra_params:
                url += f"?{extra_params}"
            requests.get(url, timeout=10)
            logger.info(f"Heartbeat pinged with status: {status}")
    except Exception as e:
        logger.error(f"Failed to ping heartbeat: {str(e)}")

def calculate_file_hash(content):
    """Calculate SHA-256 hash of file content."""
    return hashlib.sha256(content).hexdigest()

def sanitize_filename(filename):
    """Sanitize just the filename portion."""
    invalid_chars = '<>:"|?*'
    for char in invalid_chars:
        filename = filename.replace(char, '_')
    return filename.strip()

def ensure_folder_exists(dbx, path):
    """Create folder if it doesn't exist."""
    try:
        if not path or path == '/':
            return

        try:
            dbx.files_get_metadata(path)
            return  # Folder exists
        except dropbox.exceptions.ApiError as e:
            if not isinstance(e.error, dropbox.files.GetMetadataError):
                raise

        # If we get here, folder doesn't exist. Create parent first
        parent = str(Path(path).parent)
        if parent != path:  # Avoid infinite recursion
            ensure_folder_exists(dbx, parent)

        try:
            dbx.files_create_folder_v2(path)
            logger.info(f"Created folder: {path}")
        except dropbox.exceptions.ApiError as e:
            if not isinstance(e.error, dropbox.files.CreateFolderError):
                raise
            logger.warning(f"Folder already exists or conflict: {path}")

    except Exception as e:
        logger.error(f"Error handling folder {path}: {str(e)}")

def save_backup_metadata(dbx, base_path, metrics, file_hashes):
    """Save backup metadata to Dropbox."""
    try:
        metadata = {
            **metrics,
            "file_hashes": file_hashes
        }
        
        metadata_path = f"{base_path}/_backup_metadata.json"
        metadata_content = json.dumps(metadata, indent=2).encode('utf-8')
        
        dbx.files_upload(
            metadata_content,
            metadata_path,
            mode=dropbox.files.WriteMode.overwrite
        )
        logger.info(f"Backup metadata saved to: {metadata_path}")
    except Exception as e:
        logger.error(f"Failed to save backup metadata: {str(e)}")

def get_latest_backup_metadata(dbx):
    """Find and retrieve metadata from the most recent backup."""
    try:
        # List all folders in root
        result = dbx.files_list_folder('')
        
        # Pattern to match backup folders and extract their date
        backup_pattern = re.compile(r'vercel_blob_backup_(\d{8})_(\d{6})')
        
        # Find the most recent backup folder
        latest_backup = None
        latest_date = None
        
        for entry in result.entries:
            if not isinstance(entry, dropbox.files.FolderMetadata):
                continue
                
            match = backup_pattern.match(entry.name)
            if not match:
                continue
            
            try:
                folder_date_str = f"{match.group(1)}_{match.group(2)}"
                folder_date = datetime.strptime(folder_date_str, '%Y%m%d_%H%M%S')
                folder_date = folder_date.replace(tzinfo=timezone.utc)
                
                if latest_date is None or folder_date > latest_date:
                    latest_date = folder_date
                    latest_backup = entry.path_display
                    
            except ValueError:
                continue
        
        if latest_backup:
            try:
                # Get the metadata file from the latest backup
                metadata_path = f"{latest_backup}/_backup_metadata.json"
                metadata = json.loads(dbx.files_download(metadata_path)[1].content)
                logger.info(f"Found previous backup metadata: {latest_backup}")
                return metadata.get('file_hashes', {}), latest_backup
            except Exception as e:
                logger.warning(f"Could not read metadata from latest backup: {e}")
                
    except Exception as e:
        logger.warning(f"Error finding latest backup: {e}")
    
    return {}, None

@retry(stop=stop_after_attempt(3), wait=wait_exponential(multiplier=1, min=4, max=10))
def calculate_file_hash_from_url(url, headers=None):
    """Calculate hash from a URL with retry logic for network issues."""
    try:
        response = requests.get(url, headers=headers, stream=True, timeout=30)  # Add timeout
        response.raise_for_status()
        
        sha256_hash = hashlib.sha256()
        for chunk in response.iter_content(chunk_size=8192):
            sha256_hash.update(chunk)
        
        return sha256_hash.hexdigest()
    except requests.exceptions.RequestException as e:
        logger.error(f"Error downloading file from {url}: {e}")
        raise

def get_dropbox_client():
    """Initialize Dropbox client with connection timeout."""
    try:
        # Add timeout configuration
        timeout = dropbox.Dropbox._TIMEOUT = 100  # seconds
        
        refresh_token = os.environ['DROPBOX_REFRESH_TOKEN']
        app_key = os.environ['DROPBOX_APP_KEY']
        app_secret = os.environ['DROPBOX_APP_SECRET']
        
        # Initialize Dropbox client with refresh token and all required scopes
        dbx = dropbox.Dropbox(
            app_key=app_key,
            app_secret=app_secret,
            oauth2_refresh_token=refresh_token,
            scope=[
                'files.metadata.read',
                'files.metadata.write',
                'files.content.read',
                'files.content.write',
                'account_info.read'
            ],
            timeout=timeout
        )
        
        # Test the connection
        try:
            dbx.users_get_current_account()
            logger.info("Successfully connected to Dropbox")
            return dbx
        except AuthError as e:
            logger.error(f"Error authenticating with Dropbox: {str(e)}")
            raise
            
    except Exception as e:
        logger.error(f"Failed to initialize Dropbox client: {str(e)}")
        raise

def copy_file_from_previous_backup(dbx, src_path, dst_path):
    """Attempt to copy a file from previous backup with conflict handling."""
    try:
        # First, check if the destination file already exists
        try:
            dbx.files_get_metadata(dst_path)
            logger.info(f"File already exists at {dst_path}, skipping copy")
            return False
        except dropbox.exceptions.ApiError as e:
            if not isinstance(e.error, dropbox.files.GetMetadataError):
                raise

        # If we get here, the file doesn't exist at the destination
        logger.info(f"Copying {src_path} to {dst_path}")
        dbx.files_copy_v2(
            from_path=src_path,
            to_path=dst_path,
            allow_ownership_transfer=True
        )
        return True
        
    except dropbox.exceptions.ApiError as e:
        error_details = str(e)
        logger.warning(f"Detailed copy error: {error_details}")
        
        # If it's a conflict error, try to delete the destination first
        if (isinstance(e.error, dropbox.files.RelocationError) and
            isinstance(e.error.get_to(), dropbox.files.WriteError) and
            isinstance(e.error.get_to().reason, dropbox.files.WriteConflictError)):
            
            try:
                logger.info(f"Attempting to delete existing file at {dst_path}")
                dbx.files_delete_v2(dst_path)
                
                # Try the copy again
                dbx.files_copy_v2(
                    from_path=src_path,
                    to_path=dst_path,
                    allow_ownership_transfer=True
                )
                logger.info(f"Successfully copied file after deletion: {dst_path}")
                return True
                
            except Exception as delete_error:
                logger.warning(f"Failed to handle conflict for {dst_path}: {delete_error}")
                return False
        
        logger.warning(f"Failed to copy from previous backup: {e}")
        return False

def upload_file(dbx, file_path, dropbox_path):
    """Upload a file with conflict handling."""
    try:
        # First try to delete any existing file
        try:
            dbx.files_delete_v2(dropbox_path)
            logger.info(f"Deleted existing file at {dropbox_path}")
        except dropbox.exceptions.ApiError:
            pass  # File doesn't exist, which is fine
        
        # Now upload the new file
        with open(file_path, 'rb') as f:
            dbx.files_upload(
                f.read(),
                dropbox_path,
                mode=dropbox.files.WriteMode('overwrite')
            )
        logger.info(f"Successfully uploaded {file_path} to {dropbox_path}")
        
    except Exception as e:
        logger.error(f"Failed to upload {file_path}: {e}")
        raise

def cleanup_duplicates(dbx, backup_folder):
    """Clean up duplicate files in the backup folder."""
    try:
        result = dbx.files_list_folder(backup_folder, recursive=True)
        files = {}  # Dictionary to store filename -> path mapping
        
        # Find duplicates
        for entry in result.entries:
            if isinstance(entry, dropbox.files.FileMetadata):
                base_name = entry.name.split(' (')[0]  # Remove the (1), (2) etc.
                if base_name in files:
                    # Keep the newer file
                    if entry.server_modified > files[base_name]['modified']:
                        # Delete the older file
                        dbx.files_delete_v2(files[base_name]['path'])
                        files[base_name] = {
                            'path': entry.path_display,
                            'modified': entry.server_modified
                        }
                    else:
                        # Delete the current file
                        dbx.files_delete_v2(entry.path_display)
                else:
                    files[base_name] = {
                        'path': entry.path_display,
                        'modified': entry.server_modified
                    }
        
        logger.info(f"Cleanup completed for {backup_folder}")
    except Exception as e:
        logger.warning(f"Error during cleanup: {e}")

def backup_vercel_blob_to_dropbox():
    metrics = BackupMetrics()
    file_hashes = {}

    try:
        # Add connection pooling for requests
        session = requests.Session()
        
        # Add chunk size configuration
        CHUNK_SIZE = 1024 * 1024  # 1MB chunks for better memory management
        
        # Start heartbeat
        ping_heartbeat()

        # Dropbox API setup with refresh token
        dbx = get_dropbox_client()

        # Clean up old backups first
        cleanup_old_backups(dbx, metrics)

        # Get previous backup metadata
        previous_hashes, previous_backup_path = get_latest_backup_metadata(dbx)
        if previous_backup_path:
            logger.info(f"Found {len(previous_hashes)} files in previous backup")

        # Vercel Blob API endpoint
        vercel_blob_url = "https://api.vercel.com/v1/blob"
        
        # Fetch data from Vercel Blob
        headers = {
            'Authorization': f'Bearer {os.environ["BLOB_READ_WRITE_TOKEN"]}'
        }
        response = requests.get(vercel_blob_url, headers=headers)
        response.raise_for_status()

        # Parse the response
        blob_data = response.json().get('blobs', [])
        if not blob_data:
            logger.warning("No blobs found to backup")
            ping_heartbeat()
            return

        # Create a timestamped folder in Dropbox
        timestamp = datetime.now(timezone.utc).strftime('%Y%m%d_%H%M%S')
        base_path = f'/vercel_blob_backup_{timestamp}'
        
        # Ensure base folder exists
        ensure_folder_exists(dbx, base_path)
        
        # Create folder structure
        folders = set()
        for item in blob_data:
            path_parts = Path(item['pathname'])
            if path_parts.name:
                current = base_path
                for part in path_parts.parts[:-1]:
                    current = f"{current}/{part}"
                    folders.add(current)

        for folder in sorted(folders):
            ensure_folder_exists(dbx, folder)

        # Upload/copy files
        for item in blob_data:
            try:
                item_pathname = item['pathname']
                
                if item_pathname.endswith('/') or not Path(item_pathname).name:
                    logger.info(f"Skipping folder entry: {item_pathname}")
                    metrics.skipped_items += 1
                    continue
                
                item_url = item['url']
                dropbox_path = f"{base_path}/{item_pathname}".replace('\\', '/').replace('//', '/')

                # Calculate current file hash
                current_hash = calculate_file_hash_from_url(item_url, headers=headers)
                file_hashes[item_pathname] = current_hash

                # Check if file exists in previous backup with same hash
                if previous_backup_path and item_pathname in previous_hashes:
                    if current_hash == previous_hashes[item_pathname]:
                        # File hasn't changed, copy from previous backup
                        previous_file_path = f"{previous_backup_path}/{item_pathname}"
                        try:
                            dbx.files_copy_v2(previous_file_path, dropbox_path)
                            logger.info(f"Copied unchanged file from previous backup: {item_pathname}")
                            metrics.files_copied += 1
                            continue
                        except dropbox.exceptions.ApiError as e:
                            logger.warning(f"Failed to copy from previous backup, will download: {e}")

                # If we get here, either the file is new, changed, or copy failed
                content_response = session.get(item_url, stream=True)
                content_response.raise_for_status()
                
                file_size = int(content_response.headers.get('content-length', 0))
                
                if file_size > 150 * 1024 * 1024:  # 150MB
                    # Use chunked upload for large files
                    upload_session = dbx.files_upload_session_start(b'')
                    cursor = dropbox.files.UploadSessionCursor(
                        session_id=upload_session.session_id,
                        offset=0
                    )
                    
                    for chunk in content_response.iter_content(chunk_size=CHUNK_SIZE):
                        if cursor.offset + len(chunk) < file_size:
                            dbx.files_upload_session_append_v2(
                                chunk,
                                cursor
                            )
                            cursor.offset += len(chunk)
                        else:
                            commit = dropbox.files.CommitInfo(
                                path=dropbox_path,
                                mode=dropbox.files.WriteMode.overwrite
                            )
                            dbx.files_upload_session_finish(
                                chunk,
                                cursor,
                                commit
                            )
                else:
                    # Use regular upload for smaller files
                    content = content_response.content
                    dbx.files_upload(
                        content,
                        dropbox_path,
                        mode=dropbox.files.WriteMode.overwrite
                    )
                
                metrics.total_bytes_downloaded += len(content)
                metrics.files_downloaded += 1
                logger.info(f"Downloaded and uploaded new/changed file: {dropbox_path} (Size: {len(content):,} bytes)")
                
            except Exception as e:
                logger.error(f"Failed to process {item_pathname}: {str(e)}")
                metrics.failed_uploads += 1

        # Save backup metadata
        save_backup_metadata(dbx, base_path, metrics.get_summary(), file_hashes)

        # Log summary
        summary = metrics.get_summary()
        logger.info("Backup Summary:")
        logger.info(f"Duration: {summary['duration_seconds']} seconds")
        logger.info(f"Files copied from previous backup: {summary['files']['copied_from_previous']}")
        logger.info(f"Files downloaded from blob: {summary['files']['downloaded_from_blob']}")
        logger.info(f"Failed uploads: {summary['files']['failed']}")
        logger.info(f"Skipped items: {summary['files']['skipped']}")
        logger.info(f"Data downloaded: {summary['data_transfer']['bytes_downloaded']:,} bytes")
        logger.info(f"Average download speed: {summary['data_transfer']['average_speed_mbps']} Mbps")
        logger.info(f"Old backups deleted: {summary['cleanup']['backups_deleted']}")
        logger.info(f"Backup location: {base_path}")

        # Determine final status and include metrics in heartbeat
        status = "fail" if metrics.failed_uploads > 0 else "success"
        ping_heartbeat(status, f"duration={summary['duration_seconds']}&bytes={summary['data_transfer']['bytes_downloaded']}")

        # Add cleanup at the end
        backup_folder = f"/vercel_blob_backup_{timestamp}"
        cleanup_duplicates(dbx, backup_folder)

    except Exception as e:
        logger.error(f"Backup failed: {str(e)}")
        ping_heartbeat("fail")
        raise

if __name__ == "__main__":
    try:
        backup_vercel_blob_to_dropbox()
    except Exception as e:
        logger.error(f"Script failed: {str(e)}")
        ping_heartbeat("fail")
        exit(1)
