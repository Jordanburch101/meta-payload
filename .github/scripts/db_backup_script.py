import os
import requests
import dropbox
from dropbox.exceptions import ApiError, AuthError
from datetime import datetime, timezone, timedelta
import logging
import logging.handlers
from pathlib import Path
import time
import hashlib
import json
import re
from tenacity import retry, stop_after_attempt, wait_exponential
import tempfile
import subprocess
from libsql_client import create_client
import asyncio

# Set up logging similar to blob backup
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.handlers.RotatingFileHandler(
            'db_backup.log',
            maxBytes=1024*1024,  # 1MB
            backupCount=5
        ),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class BackupMetrics:
    def __init__(self):
        self.start_time = time.time()
        self.total_bytes = 0
        self.backup_successful = False
        self.deleted_backups = 0

    def get_summary(self):
        duration = time.time() - self.start_time
        return {
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "duration_seconds": round(duration, 2),
            "backup": {
                "successful": self.backup_successful,
                "size_bytes": self.total_bytes,
            },
            "cleanup": {
                "backups_deleted": self.deleted_backups
            }
        }

def get_dropbox_client():
    """Initialize Dropbox client with connection timeout."""
    try:
        timeout = dropbox.Dropbox._TIMEOUT = 100
        
        refresh_token = os.environ['DROPBOX_REFRESH_TOKEN']
        app_key = os.environ['DROPBOX_APP_KEY']
        app_secret = os.environ['DROPBOX_APP_SECRET']
        
        dbx = dropbox.Dropbox(
            app_key=app_key,
            app_secret=app_secret,
            oauth2_refresh_token=refresh_token,
            timeout=timeout
        )
        
        # Test the connection
        dbx.users_get_current_account()
        logger.info("Successfully connected to Dropbox")
        return dbx
    except Exception as e:
        logger.error(f"Failed to initialize Dropbox client: {str(e)}")
        raise

def ensure_folder_exists(dbx, path):
    """Create folder if it doesn't exist."""
    try:
        try:
            dbx.files_get_metadata(path)
            logger.info(f"Folder exists: {path}")
            return True
        except dropbox.exceptions.ApiError as e:
            if not isinstance(e.error, dropbox.files.GetMetadataError):
                raise
            
            # Folder doesn't exist, create it
            dbx.files_create_folder_v2(path)
            logger.info(f"Created folder: {path}")
            return True
            
    except Exception as e:
        logger.error(f"Error handling folder {path}: {str(e)}")
        return False

def cleanup_old_backups(dbx, metrics, retention_days=30):
    """Delete backups older than the specified retention period."""
    try:
        logger.info(f"Starting cleanup of backups older than {retention_days} days...")
        
        # Ensure backup folder exists
        backup_folder = '/turso_db_backups'
        if not ensure_folder_exists(dbx, backup_folder):
            logger.warning("Could not create backup folder, skipping cleanup")
            return
        
        cutoff_date = datetime.now(timezone.utc) - timedelta(days=retention_days)
        result = dbx.files_list_folder(backup_folder)
        
        backup_pattern = re.compile(r'backup_(\d{8})_(\d{6})\.sqlite')
        
        for entry in result.entries:
            if not isinstance(entry, dropbox.files.FileMetadata):
                continue
                
            match = backup_pattern.match(entry.name)
            if not match:
                continue
            
            try:
                folder_date_str = f"{match.group(1)}_{match.group(2)}"
                folder_date = datetime.strptime(folder_date_str, '%Y%m%d_%H%M%S')
                folder_date = folder_date.replace(tzinfo=timezone.utc)
                
                if folder_date < cutoff_date:
                    logger.info(f"Deleting old backup: {entry.name} (from {folder_date.date()})")
                    dbx.files_delete_v2(entry.path_display)
                    metrics.deleted_backups += 1
                    
            except ValueError as e:
                logger.warning(f"Could not parse date from filename {entry.name}: {e}")
            
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

async def backup_database():
    metrics = BackupMetrics()
    
    try:
        # Start heartbeat
        ping_heartbeat()

        # Initialize Dropbox client
        dbx = get_dropbox_client()

        # Clean up old backups first
        cleanup_old_backups(dbx, metrics)

        # Create a temporary file to store the backup
        with tempfile.NamedTemporaryFile(suffix='.sqlite', delete=False) as temp_file:
            temp_path = temp_file.name

        # Initialize Turso client
        client = create_client(
            url=os.environ['TURSO_DATABASE_URL'],
            auth_token=os.environ['TURSO_AUTH_TOKEN']
        )

        # Perform database backup
        try:
            # Execute VACUUM INTO command
            result = await client.execute("VACUUM INTO ?", [temp_path])
            logger.info(f"Database backup created at: {temp_path}")
            
            # Get file size
            file_size = os.path.getsize(temp_path)
            metrics.total_bytes = file_size
            
            # Create timestamp for backup filename
            timestamp = datetime.now(timezone.utc).strftime('%Y%m%d_%H%M%S')
            dropbox_path = f"/turso_db_backups/backup_{timestamp}.sqlite"
            
            # Upload to Dropbox
            with open(temp_path, 'rb') as f:
                dbx.files_upload(
                    f.read(),
                    dropbox_path,
                    mode=dropbox.files.WriteMode.overwrite
                )
            
            logger.info(f"Database backup uploaded to Dropbox: {dropbox_path}")
            metrics.backup_successful = True
            
        finally:
            # Clean up temporary file
            if os.path.exists(temp_path):
                os.unlink(temp_path)
            
            # Close database connection
            await client.close()

        # Log summary
        summary = metrics.get_summary()
        logger.info("Backup Summary:")
        logger.info(f"Duration: {summary['duration_seconds']} seconds")
        logger.info(f"Backup size: {summary['backup']['size_bytes']:,} bytes")
        logger.info(f"Success: {summary['backup']['successful']}")
        logger.info(f"Old backups deleted: {summary['cleanup']['backups_deleted']}")

        # Final heartbeat
        status = "success" if metrics.backup_successful else "fail"
        ping_heartbeat(status, f"duration={summary['duration_seconds']}&bytes={summary['backup']['size_bytes']}")

    except Exception as e:
        logger.error(f"Backup failed: {str(e)}")
        ping_heartbeat("fail")
        raise

if __name__ == "__main__":
    try:
        asyncio.run(backup_database())
    except Exception as e:
        logger.error(f"Script failed: {str(e)}")
        ping_heartbeat("fail")
        exit(1) 