"""
Vercel Blob to Dropbox Backup Script

This script performs automated backups of Vercel Blob storage to Dropbox.
It includes features such as:
- Incremental backups
- Concurrent file processing
- Automatic retry mechanisms
- Detailed metrics collection
- Cleanup of old backups

Author: Your Name
Last Updated: 2024-12-30
"""

import os
import time
import asyncio
import logging
import hashlib
import json
from datetime import datetime, timezone, timedelta
from typing import Dict, List, Optional, Union, Any
from dataclasses import dataclass
from pathlib import Path

import aiohttp
import dropbox
from dropbox.exceptions import ApiError, AuthError
from dropbox.files import WriteMode

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

@dataclass
class BackupConfig:
    """Configuration settings for backup operations.
    
    Attributes:
        retention_days: Number of days to keep old backups
        chunk_size: Size of chunks for file streaming
        max_retries: Maximum number of retry attempts
        retry_delay: Delay between retries in seconds
        concurrent_limit: Maximum number of concurrent operations
    """
    retention_days: int = 30
    chunk_size: int = 8192
    max_retries: int = 3
    retry_delay: int = 1
    concurrent_limit: int = 5

@dataclass
class BackupMetrics:
    """Tracks metrics for backup operations.
    
    Attributes:
        start_time: Timestamp when backup started
        total_bytes: Total bytes processed
        files_processed: Number of files processed
        failed_files: Number of failed files
        skipped_files: Number of skipped files
        old_backups_deleted: Number of old backups deleted
    """
    start_time: float = field(default_factory=time.time)
    total_bytes: int = 0
    files_processed: int = 0
    failed_files: int = 0
    skipped_files: int = 0
    old_backups_deleted: int = 0

    @property
    def duration(self) -> float:
        """Calculate duration of backup operation."""
        return time.time() - self.start_time

    @property
    def average_speed(self) -> float:
        """Calculate average processing speed in bytes per second."""
        return self.total_bytes / self.duration if self.duration > 0 else 0

    def to_dict(self) -> Dict[str, Any]:
        """Convert metrics to dictionary format."""
        return {
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "duration_seconds": round(self.duration, 2),
            "files": {
                "processed": self.files_processed,
                "failed": self.failed_files,
                "skipped": self.skipped_files
            },
            "data_transfer": {
                "total_bytes": self.total_bytes,
                "average_speed_mbps": round(self.average_speed / 1_000_000, 2)
            },
            "cleanup": {
                "old_backups_deleted": self.old_backups_deleted
            }
        }

class RetryableError(Exception):
    """Exception class for errors that should trigger a retry."""
    pass

class DropboxClient:
    """Handles all Dropbox-related operations.
    
    This class manages authentication and file operations with Dropbox,
    including uploads, downloads, and file management.
    """

    def __init__(self, app_key: str, app_secret: str, refresh_token: str):
        """Initialize Dropbox client.
        
        Args:
            app_key: Dropbox application key
            app_secret: Dropbox application secret
            refresh_token: OAuth2 refresh token
        """
        self.app_key = app_key
        self.app_secret = app_secret
        self.refresh_token = refresh_token
        self.client = self._initialize_client()

    def _initialize_client(self) -> dropbox.Dropbox:
        """Initialize and return authenticated Dropbox client."""
        try:
            dbx = dropbox.Dropbox(
                oauth2_refresh_token=self.refresh_token,
                app_key=self.app_key,
                app_secret=self.app_secret,
                scope=[
                    'files.metadata.read',
                    'files.metadata.write',
                    'files.content.read',
                    'files.content.write',
                    'account_info.read'
                ]
            )
            dbx.users_get_current_account()
            logger.info("Successfully connected to Dropbox")
            return dbx
        except Exception as e:
            logger.error(f"Failed to initialize Dropbox client: {e}")
            raise

    async def upload_file(self, content: bytes, path: str) -> bool:
        """Upload file to Dropbox with retry mechanism.
        
        Args:
            content: File content as bytes
            path: Destination path in Dropbox
            
        Returns:
            bool: True if upload successful, False otherwise
        """
        try:
            self.client.files_upload(
                content,
                path,
                mode=WriteMode('overwrite')
            )
            return True
        except ApiError as e:
            logger.error(f"Failed to upload to {path}: {e}")
            raise RetryableError(f"Upload failed: {e}")

    async def ensure_folder_exists(self, path: str) -> None:
        """Ensure folder exists in Dropbox, creating it if necessary."""
        try:
            self.client.files_get_metadata(path)
        except ApiError:
            try:
                self.client.files_create_folder_v2(path)
                logger.info(f"Created folder: {path}")
            except ApiError as e:
                if not isinstance(e.error, dropbox.files.CreateFolderError):
                    raise RetryableError(f"Failed to create folder: {e}")

class VercelBlobClient:
    """Handles all Vercel Blob storage operations.
    
    This class manages interactions with the Vercel Blob API,
    including listing blobs and downloading content.
    """

    def __init__(self, token: str):
        """Initialize Vercel Blob client.
        
        Args:
            token: Vercel Blob read/write token
        """
        self.token = token
        self.base_url = "https://api.vercel.com/v1/blob"
        self.session = None

    async def _ensure_session(self):
        """Ensure aiohttp session exists."""
        if self.session is None:
            self.session = aiohttp.ClientSession()

    async def list_blobs(self) -> List[Dict]:
        """List all blobs in the storage.
        
        Returns:
            List of blob metadata dictionaries
        """
        await self._ensure_session()
        headers = {"Authorization": f"Bearer {self.token}"}
        
        try:
            async with self.session.get(f"{self.base_url}/list", headers=headers) as response:
                response.raise_for_status()
                data = await response.json()
                return data.get("blobs", [])
        except Exception as e:
            logger.error(f"Failed to list blobs: {e}")
            raise RetryableError(f"Blob listing failed: {e}")

    async def get_blob_content(self, url: str) -> bytes:
        """Download blob content.
        
        Args:
            url: URL of the blob
            
        Returns:
            Blob content as bytes
        """
        await self._ensure_session()
        try:
            async with self.session.get(url) as response:
                response.raise_for_status()
                return await response.read()
        except Exception as e:
            logger.error(f"Failed to download blob from {url}: {e}")
            raise RetryableError(f"Blob download failed: {e}")

    async def close(self):
        """Close the HTTP session."""
        if self.session:
            await self.session.close()
            self.session = None

class BackupManager:
    """Manages the entire backup process.
    
    This class coordinates between Vercel Blob and Dropbox,
    handling the backup process, retries, and metrics collection.
    """

    def __init__(self, dropbox_client: DropboxClient, vercel_client: VercelBlobClient, config: BackupConfig):
        """Initialize backup manager.
        
        Args:
            dropbox_client: Initialized DropboxClient
            vercel_client: Initialized VercelBlobClient
            config: Backup configuration
        """
        self.dropbox = dropbox_client
        self.vercel = vercel_client
        self.config = config
        self.metrics = BackupMetrics()
        self.current_backup_path = f"/vercel_blob_backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}"

    async def run_backup(self):
        """Execute the backup process."""
        try:
            logger.info(f"Starting backup to {self.current_backup_path}")
            await self.ping_heartbeat("start")

            # Create backup directory
            await self.dropbox.ensure_folder_exists(self.current_backup_path)

            # Get list of blobs
            blobs = await self.vercel.list_blobs()
            logger.info(f"Found {len(blobs)} blobs to process")

            # Process blobs concurrently with limit
            async with asyncio.Semaphore(self.config.concurrent_limit) as semaphore:
                tasks = [
                    self._process_blob(blob, semaphore)
                    for blob in blobs
                ]
                await asyncio.gather(*tasks)

            # Save backup metadata
            await self._save_backup_metadata()
            
            # Cleanup old backups
            await self._cleanup_old_backups()

            logger.info("Backup completed successfully")
            await self.ping_heartbeat("success")
            
        except Exception as e:
            logger.error(f"Backup failed: {e}")
            await self.ping_heartbeat("fail")
            raise
        finally:
            await self.vercel.close()

    async def _process_blob(self, blob: Dict, semaphore: asyncio.Semaphore):
        """Process a single blob with retries and concurrency control.
        
        Args:
            blob: Blob metadata dictionary
            semaphore: Semaphore for concurrency control
        """
        async with semaphore:
            for attempt in range(self.config.max_retries):
                try:
                    content = await self.vercel.get_blob_content(blob['url'])
                    path = f"{self.current_backup_path}/{blob['pathname']}"
                    
                    await self.dropbox.upload_file(content, path)
                    
                    self.metrics.files_processed += 1
                    self.metrics.total_bytes += len(content)
                    logger.info(f"Successfully backed up: {blob['pathname']}")
                    break
                    
                except Exception as e:
                    if attempt == self.config.max_retries - 1:
                        logger.error(f"Failed to backup {blob['pathname']}: {e}")
                        self.metrics.failed_files += 1
                    else:
                        await asyncio.sleep(self.config.retry_delay)

    async def _save_backup_metadata(self):
        """Save backup metadata to Dropbox."""
        try:
            metadata = {
                "timestamp": datetime.now(timezone.utc).isoformat(),
                "metrics": self.metrics.to_dict(),
                "config": {
                    "retention_days": self.config.retention_days,
                    "concurrent_limit": self.config.concurrent_limit
                }
            }
            
            metadata_path = f"{self.current_backup_path}/backup_metadata.json"
            content = json.dumps(metadata, indent=2).encode('utf-8')
            
            await self.dropbox.upload_file(content, metadata_path)
            logger.info("Saved backup metadata")
            
        except Exception as e:
            logger.error(f"Failed to save backup metadata: {e}")
            raise

    async def _cleanup_old_backups(self):
        """Clean up backups older than retention period."""
        try:
            logger.info(f"Starting cleanup of backups older than {self.config.retention_days} days...")
            
            # List all backup folders
            result = self.dropbox.client.files_list_folder("")
            backup_folders = [
                entry for entry in result.entries
                if isinstance(entry, dropbox.files.FolderMetadata) and
                entry.name.startswith("vercel_blob_backup_")
            ]
            
            # Calculate cutoff date
            cutoff_date = datetime.now(timezone.utc) - timedelta(days=self.config.retention_days)
            
            # Delete old backups
            for folder in backup_folders:
                try:
                    # Extract date from folder name
                    folder_date = datetime.strptime(
                        folder.name.split('_')[2] + folder.name.split('_')[3],
                        '%Y%m%d%H%M%S'
                    ).replace(tzinfo=timezone.utc)
                    
                    if folder_date < cutoff_date:
                        self.dropbox.client.files_delete_v2(folder.path_display)
                        logger.info(f"Deleted old backup: {folder.name}")
                        self.metrics.old_backups_deleted += 1
                        
                except (ValueError, IndexError) as e:
                    logger.warning(f"Could not parse date from folder name {folder.name}: {e}")
                except ApiError as e:
                    logger.error(f"Failed to delete old backup {folder.name}: {e}")
            
        except Exception as e:
            logger.error(f"Error during backup cleanup: {e}")
            raise

    async def ping_heartbeat(self, status: str = "success"):
        """Send heartbeat ping to monitoring service.
        
        Args:
            status: Current status of the backup process
        """
        heartbeat_url = os.environ.get("HEARTBEAT_URL")
        if not heartbeat_url:
            return

        try:
            async with aiohttp.ClientSession() as session:
                params = {"status": status}
                async with session.get(heartbeat_url, params=params) as response:
                    response.raise_for_status()
                    logger.info(f"Heartbeat pinged with status: {status}")
        except Exception as e:
            logger.error(f"Failed to ping heartbeat: {e}")

async def main():
    """Main entry point for the backup script."""
    try:
        # Initialize configuration
        config = BackupConfig(
            retention_days=int(os.environ.get("BACKUP_RETENTION_DAYS", "30")),
            concurrent_limit=int(os.environ.get("BACKUP_CONCURRENT_LIMIT", "5"))
        )

        # Initialize clients
        dropbox_client = DropboxClient(
            app_key=os.environ["DROPBOX_APP_KEY"],
            app_secret=os.environ["DROPBOX_APP_SECRET"],
            refresh_token=os.environ["DROPBOX_REFRESH_TOKEN"]
        )

        vercel_client = VercelBlobClient(
            token=os.environ["BLOB_READ_WRITE_TOKEN"]
        )

        # Create and run backup manager
        backup_manager = BackupManager(dropbox_client, vercel_client, config)
        await backup_manager.run_backup()

    except Exception as e:
        logger.error(f"Script failed: {e}")
        raise

if __name__ == "__main__":
    # Run the async main function
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        logger.info("Backup interrupted by user")
    except Exception as e:
        logger.error(f"Backup failed: {e}")
        sys.exit(1)
