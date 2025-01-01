import dropbox
from dropbox import DropboxOAuth2FlowNoRedirect
import os

# Add your app key and secret here
APP_KEY = "YOUR_APP_KEY"
APP_SECRET = "YOUR_APP_SECRET"

SCOPES = [
    'files.metadata.read',
    'files.metadata.write',
    'files.content.read',
    'files.content.write',
    'account_info.read'  # Added this scope
]

auth_flow = DropboxOAuth2FlowNoRedirect(
    APP_KEY, 
    APP_SECRET,
    token_access_type='offline',
    scope=SCOPES
)

authorize_url = auth_flow.start()
print("1. Go to: " + authorize_url)
print("2. Click \"Allow\" (you might have to log in first)")
print("3. Copy the authorization code.")
auth_code = input("Enter the authorization code here: ").strip()

try:
    oauth_result = auth_flow.finish(auth_code)
    print("Refresh token:", oauth_result.refresh_token)
except Exception as e:
    print('Error:', str(e))