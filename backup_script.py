import os
import requests
import dropbox
from datetime import datetime, timedelta

# Supabase credentials
supabase_url = os.environ['SUPABASE_URL']
supabase_key = os.environ['SUPABASE_KEY']
bucket_name = os.environ['SUPABASE_BUCKET_NAME']

# Dropbox credentials
dropbox_access_token = os.environ['DROPBOX_ACCESS_TOKEN']

# Dropbox client setup
dbx = dropbox.Dropbox(dropbox_access_token)

def list_bucket_contents():
    url = f"{supabase_url}/storage/v1/object/list/{bucket_name}"
    headers = {
        "Authorization": f"Bearer {supabase_key}",
        "apikey": supabase_key
    }
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        return response.json()
    else:
        print(f"Error listing bucket contents: {response.status_code}")
        print(response.text)
        return []

def download_file(file_path):
    url = f"{supabase_url}/storage/v1/object/{bucket_name}/{file_path}"
    headers = {
        "Authorization": f"Bearer {supabase_key}",
        "apikey": supabase_key
    }
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        return response.content
    else:
        print(f"Error downloading file {file_path}: {response.status_code}")
        print(response.text)
        return None

def backup_to_dropbox():
    current_date = datetime.now().strftime("%Y-%m-%d")
    
    files = list_bucket_contents()
    if not files:
        print("No files found in the bucket or error occurred while listing files.")
        return

    for file in files:
        if isinstance(file, dict) and 'name' in file:
            file_name = file['name']
            file_content = download_file(file_name)
            if file_content:
                dropbox_path = f"/backups/{current_date}/{file_name}"
                try:
                    dbx.files_upload(file_content, dropbox_path, mode=dropbox.files.WriteMode.overwrite)
                    print(f"Backed up: {file_name}")
                except Exception as e:
                    print(f"Error uploading {file_name} to Dropbox: {str(e)}")
        else:
            print(f"Unexpected file structure: {file}")

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

