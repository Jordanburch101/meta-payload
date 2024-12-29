import os
import requests
import dropbox

def backup_vercel_blob_to_dropbox():
    # Vercel Blob API endpoint
    vercel_blob_url = "https://api.vercel.com/v1/blob"  # Update with actual endpoint if needed

    # Dropbox API setup
    dbx = dropbox.Dropbox(os.environ['DROPBOX_ACCESS_TOKEN'])

    # Fetch data from Vercel Blob
    headers = {
        'Authorization': f'Bearer {os.environ["BLOB_READ_WRITE_TOKEN"]}'
    }
    response = requests.get(vercel_blob_url, headers=headers)
    response.raise_for_status()

    # Save data to Dropbox
    file_path = '/backup/vercel_blob_backup.json'  # Update with desired Dropbox path
    dbx.files_upload(response.content, file_path, mode=dropbox.files.WriteMode.overwrite)

    print(f"Backup successful: {file_path}")

if __name__ == "__main__":
    backup_vercel_blob_to_dropbox()
