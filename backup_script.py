import os
import boto3
import dropbox
from datetime import datetime, timedelta

# Supabase S3-compatible credentials
supabase_url = os.environ['SUPABASE_URL']
supabase_key = os.environ['SUPABASE_KEY']

# Dropbox credentials
dropbox_access_token = os.environ['DROPBOX_ACCESS_TOKEN']

# S3 client setup
s3 = boto3.client(
    's3',
    endpoint_url=f"{supabase_url}/storage/v1",
    aws_access_key_id=supabase_key,
    aws_secret_access_key=supabase_key
)

# Dropbox client setup
dbx = dropbox.Dropbox(dropbox_access_token)

def backup_to_dropbox():
    # Get current date for the backup folder name
    current_date = datetime.now().strftime("%Y-%m-%d")
    
    # List all objects in the Supabase bucket
    response = s3.list_objects_v2(Bucket='meta-payload-main-bucket')
    
    for obj in response.get('Contents', []):
        # Get the object
        file_obj = s3.get_object(Bucket='your-bucket-name', Key=obj['Key'])
        file_content = file_obj['Body'].read()
        
        # Upload to Dropbox
        dropbox_path = f"/backups/{current_date}/{obj['Key']}"
        dbx.files_upload(file_content, dropbox_path, mode=dropbox.files.WriteMode.overwrite)

def delete_old_backups():
    # Calculate the date 30 days ago
    thirty_days_ago = (datetime.now() - timedelta(days=30)).strftime("%Y-%m-%d")
    
    # List all folders in the backups directory
    result = dbx.files_list_folder("/backups")
    
    for entry in result.entries:
        if isinstance(entry, dropbox.files.FolderMetadata):
            if entry.name < thirty_days_ago:
                dbx.files_delete_v2(f"/backups/{entry.name}")

if __name__ == "__main__":
    backup_to_dropbox()
    delete_old_backups()

