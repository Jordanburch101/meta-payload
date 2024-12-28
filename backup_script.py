import os
import boto3
import dropbox
from botocore.client import Config
from datetime import datetime, timedelta

# Supabase Storage (S3) credentials
supabase_url = os.environ['SUPABASE_URL']
supabase_key = os.environ['SUPABASE_KEY']
bucket_name = os.environ['SUPABASE_BUCKET_NAME']

# Dropbox credentials
dropbox_access_token = os.environ['DROPBOX_ACCESS_TOKEN']

# S3 client setup
s3 = boto3.client(
    's3',
    endpoint_url=f"{supabase_url}/storage/v1",
    aws_access_key_id=supabase_key,
    aws_secret_access_key=supabase_key,
    config=Config(signature_version='s3v4'),
    region_name='ap-southeast-2'  # This is a placeholder, Supabase doesn't use regions
)

# Dropbox client setup
dbx = dropbox.Dropbox(dropbox_access_token)

def backup_to_dropbox():
    current_date = datetime.now().strftime("%Y-%m-%d")
    
    # List all objects in the bucket
    response = s3.list_objects_v2(Bucket=bucket_name)
    
    if 'Contents' not in response:
        print("No files found in the bucket or error occurred while listing files.")
        return

    for obj in response['Contents']:
        file_name = obj['Key']
        try:
            # Get the object
            file_obj = s3.get_object(Bucket=bucket_name, Key=file_name)
            file_content = file_obj['Body'].read()
            
            # Upload to Dropbox
            dropbox_path = f"/backups/{current_date}/{file_name}"
            dbx.files_upload(file_content, dropbox_path, mode=dropbox.files.WriteMode.overwrite)
            print(f"Backed up: {file_name}")
        except Exception as e:
            print(f"Error processing {file_name}: {str(e)}")

def delete_old_backups():
    thirty_days_ago = (datetime.now() - timedelta(days=30)).strftime("%Y-%m-%d")
    
    try:
        result = dbx.files_list_folder("/backups")
        
        for entry in result.entries:
            if isinstance(entry, dropbox.files.FolderMetadata):
                if entry.name < thirty_days_ago:
                    dbx.files_delete_v2(f"/backups/{entry.name}")
                    print(f"Deleted old backup: {entry.name}")
    except Exception as e:
        print(f"Error deleting old backups: {str(e)}")

if __name__ == "__main__":
    backup_to_dropbox()
    delete_old_backups()

