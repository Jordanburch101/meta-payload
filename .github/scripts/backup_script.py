import os
import requests
import dropbox
from datetime import datetime
import logging
from pathlib import Path

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

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

def backup_vercel_blob_to_dropbox():
    try:
        # Vercel Blob API endpoint
        vercel_blob_url = "https://api.vercel.com/v1/blob"
        
        # Dropbox API setup
        dbx = dropbox.Dropbox(os.environ['DROPBOX_ACCESS_TOKEN'])

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
            return

        # Create a timestamped folder in Dropbox
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        base_path = f'/vercel_blob_backup_{timestamp}'
        
        # Ensure base folder exists
        ensure_folder_exists(dbx, base_path)
        
        # First pass: Create all necessary folders
        folders = set()
        for item in blob_data:
            path_parts = Path(item['pathname'])
            current = base_path
            for part in path_parts.parts[:-1]:  # Exclude filename
                current = f"{current}/{part}"
                folders.add(current)

        # Create all folders first
        for folder in sorted(folders):  # Sort to ensure parent folders are created first
            ensure_folder_exists(dbx, folder)
        
        # Track success and failures
        successful_uploads = 0
        failed_uploads = 0

        # Second pass: Upload files
        for item in blob_data:
            try:
                item_pathname = item['pathname']
                item_url = item['url']
                
                # Construct the full Dropbox path
                dropbox_path = f"{base_path}/{item_pathname}"
                dropbox_path = dropbox_path.replace('\\', '/').replace('//', '/')
                
                # Skip if this is just a folder
                if not Path(item_pathname).name:
                    continue
                
                # Download the content
                content_response = requests.get(item_url)
                content_response.raise_for_status()
                
                # Upload to Dropbox
                dbx.files_upload(
                    content_response.content,
                    dropbox_path,
                    mode=dropbox.files.WriteMode.overwrite
                )
                
                logger.info(f"Successfully uploaded: {dropbox_path}")
                successful_uploads += 1
                
            except Exception as e:
                logger.error(f"Failed to upload {item_pathname}: {str(e)}")
                failed_uploads += 1

        # Log summary
        logger.info(f"Backup completed. Success: {successful_uploads}, Failed: {failed_uploads}")
        logger.info(f"Backup location: {base_path}")

    except Exception as e:
        logger.error(f"Backup failed: {str(e)}")
        raise

if __name__ == "__main__":
    try:
        backup_vercel_blob_to_dropbox()
    except Exception as e:
        logger.error(f"Script failed: {str(e)}")
        exit(1)
