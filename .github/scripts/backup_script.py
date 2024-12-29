import os
import sys
import requests
import dropbox
from datetime import datetime, timedelta
from dateutil.parser import parse
import json

# Configuration
DROPBOX_ACCESS_TOKEN = os.environ['DROPBOX_ACCESS_TOKEN']
BLOB_READ_WRITE_TOKEN = os.environ['BLOB_READ_WRITE_TOKEN']
BACKUP_FOLDER_NAME = os.environ.get('BACKUP_FOLDER_NAME', 'vercel-blob-backups')
RETENTION_DAYS = int(os.environ.get('RETENTION_DAYS', '7'))

def get_vercel_blobs():
    """Retrieve all blobs from Vercel"""
    headers = {
        'Authorization': f'Bearer {BLOB_READ_WRITE_TOKEN}',
        'Content-Type': 'application/json',
    }
    
    url = 'https://blob.vercel-storage.com/list'
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    
    return response.json()

def download_blob(url):
    """Download blob content from Vercel"""
    headers = {
        'Authorization': f'Bearer {BLOB_READ_WRITE_TOKEN}'
    }
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    return response.content

def upload_to_dropbox(dbx, backup_path, content):
    """Upload content to Dropbox"""
    try:
        dbx.files_upload(content, backup_path, mode=dropbox.files.WriteMode.overwrite)
        print(f"Uploaded: {backup_path}")
    except dropbox.exceptions.ApiError as e:
        print(f"Failed to upload {backup_path}: {e}")
        raise

def cleanup_old_backups(dbx, base_path, retention_days):
    """Delete backups older than retention_days"""
    try:
        result = dbx.files_list_folder(base_path)
        cutoff_date = datetime.now() - timedelta(days=retention_days)
        
        for entry in result.entries:
            if isinstance(entry, dropbox.files.FolderMetadata):
                try:
                    # Extract date from folder name (format: YYYY-MM-DD_HH-MM-SS)
                    folder_date = parse(entry.name.split('_')[0])
                    if folder_date < cutoff_date:
                        print(f"Deleting old backup: {entry.path_display}")
                        dbx.files_delete_v2(entry.path_display)
                except (ValueError, IndexError):
                    print(f"Skipping folder with invalid date format: {entry.name}")
                    continue
                
    except dropbox.exceptions.ApiError as e:
        print(f"Failed to cleanup old backups: {e}")
        raise

def main():
    try:
        # Initialize Dropbox client
        dbx = dropbox.Dropbox(DROPBOX_ACCESS_TOKEN)
        
        # Create timestamp for backup folder
        timestamp = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
        base_path = f"/{BACKUP_FOLDER_NAME}"
        backup_path = f"{base_path}/{timestamp}"
        
        # Ensure base backup directory exists
        try:
            dbx.files_create_folder_v2(base_path)
        except dropbox.exceptions.ApiError:
            pass  # Folder already exists
        
        # Get all blobs from Vercel
        blobs = get_vercel_blobs()
        
        # Create metadata file
        metadata = {
            'backup_date': timestamp,
            'blobs': blobs
        }
        
        # Upload metadata
        metadata_path = f"{backup_path}/metadata.json"
        upload_to_dropbox(dbx, metadata_path, json.dumps(metadata, indent=2).encode())
        
        # Download and upload each blob
        for blob in blobs['blobs']:
            blob_content = download_blob(blob['url'])
            blob_path = f"{backup_path}/blobs/{blob['pathname']}"
            upload_to_dropbox(dbx, blob_path, blob_content)
        
        # Cleanup old backups
        cleanup_old_backups(dbx, base_path, RETENTION_DAYS)
        
        print("Backup completed successfully!")
        
    except Exception as e:
        print(f"Backup failed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
