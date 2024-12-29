import os
import requests
import dropbox
from datetime import datetime

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

    # Parse the response
    blob_data = response.json().get('blobs', [])

    # Create a timestamped folder in Dropbox
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    base_path = f'/backup/vercel_blob_backup_{timestamp}'

    # Function to upload files to Dropbox
    def upload_to_dropbox(path, content):
        dbx.files_upload(content, path, mode=dropbox.files.WriteMode.overwrite)

    # Iterate over the blob data and upload each item
    for item in blob_data:
        # Access the 'pathname' and 'url' keys
        item_path = item['pathname']
        item_content = requests.get(item['url'], headers=headers).content

        # Construct the full Dropbox path
        dropbox_path = f"{base_path}/{item_path}"

        # Upload the item to Dropbox
        upload_to_dropbox(dropbox_path, item_content)

    print(f"Backup successful: {base_path}")

if __name__ == "__main__":
    backup_vercel_blob_to_dropbox()
