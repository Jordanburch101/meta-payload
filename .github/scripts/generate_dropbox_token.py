import dropbox
from dropbox import DropboxOAuth2FlowNoRedirect
import os

# Add your app key and secret here
APP_KEY = "YOUR_APP_KEY"
APP_SECRET = "YOUR_APP_SECRET"

# Start the OAuth flow
auth_flow = DropboxOAuth2FlowNoRedirect(APP_KEY, APP_SECRET)

# Get the authorization URL
authorize_url = auth_flow.start()
print("1. Go to this URL:", authorize_url)
print("2. Click 'Allow' (you might have to log in first)")
print("3. Copy the authorization code.")

# Get the authorization code from user input
auth_code = input("Enter the authorization code here: ").strip()

try:
    # Exchange the authorization code for refresh token and access token
    oauth_result = auth_flow.finish(auth_code)
    
    print("\nSuccess! Here are your tokens:")
    print("-" * 50)
    print(f"Refresh Token: {oauth_result.refresh_token}")
    print(f"Access Token: {oauth_result.access_token}")
    print("-" * 50)
    print("\nAdd the refresh token to your GitHub secrets as DROPBOX_REFRESH_TOKEN")
    
except Exception as e:
    print('Error:', str(e)) 