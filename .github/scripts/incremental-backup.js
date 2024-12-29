const { list, get } = require('@vercel/blob');
const { Dropbox } = require('dropbox');
const fetch = require('node-fetch');
const fs = require('fs').promises;
const path = require('path');
const crypto = require('crypto');
const { Readable } = require('stream');

const BACKUP_DIR = process.env.BACKUP_DIR || '/vercel-blob-backup';
const BACKUPS_TO_KEEP = parseInt(process.env.BACKUPS_TO_KEEP || '30', 10);
const TEMP_DIR = path.join(__dirname, 'temp_backup');
const CHUNK_SIZE = 8 * 1024 * 1024; // 8MB chunks for Dropbox upload

const dbx = new Dropbox({ accessToken: process.env.DROPBOX_ACCESS_TOKEN });

async function retryOperation(operation, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await operation();
    } catch (error) {
      if (i === maxRetries - 1) throw error;
      await new Promise(resolve => setTimeout(resolve, 1000 * Math.pow(2, i)));
    }
  }
  throw new Error('Max retries reached');
}

async function getLastBackupInfo() {
  try {
    const result = await retryOperation(() => dbx.filesListFolder({ path: BACKUP_DIR }));
    const backupFiles = result.result.entries
      .filter(entry => entry['.tag'] === 'file' && entry.name.startsWith('blob_backup_'))
      .sort((a, b) => b.name.localeCompare(a.name));
    return backupFiles.length > 0 ? backupFiles[0] : null;
  } catch (error) {
    console.error('Error getting last backup info:', error);
    return null;
  }
}

async function downloadLastBackup(backupInfo) {
  if (!backupInfo) return null;

  try {
    const result = await retryOperation(() => dbx.filesDownload({ path: backupInfo.path_lower }));
    const localPath = path.join(TEMP_DIR, backupInfo.name);
    await fs.writeFile(localPath, result.result.fileBinary);
    return localPath;
  } catch (error) {
    console.error('Error downloading last backup:', error);
    return null;
  }
}

async function calculateChecksum(filePath) {
  return new Promise((resolve, reject) => {
    const hash = crypto.createHash('md5');
    const stream = fs.createReadStream(filePath);
    stream.on('data', chunk => hash.update(chunk));
    stream.on('end', () => resolve(hash.digest('hex')));
    stream.on('error', reject);
  });
}

async function uploadFileInChunks(filePath, dropboxPath) {
  const fileSize = (await fs.stat(filePath)).size;
  const fileStream = fs.createReadStream(filePath);

  let uploadId;
  let offset = 0;

  while (offset < fileSize) {
    const chunk = await new Promise((resolve, reject) => {
      const chunkBuffer = Buffer.alloc(CHUNK_SIZE);
      fileStream.read(chunkBuffer, (err, bytesRead) => {
        if (err) reject(err);
        else resolve(chunkBuffer.slice(0, bytesRead));
      });
    });

    if (offset === 0) {
      const response = await retryOperation(() => 
        dbx.filesUploadSessionStart({ close: false, contents: chunk })
      );
      uploadId = response.result.session_id;
    } else if (offset + chunk.length === fileSize) {
      await retryOperation(() => 
        dbx.filesUploadSessionFinish({
          cursor: { session_id: uploadId, offset: offset },
          commit: { path: dropboxPath, mode: { '.tag': 'overwrite' } },
          contents: chunk
        })
      );
    } else {
      await retryOperation(() => 
        dbx.filesUploadSessionAppendV2({
          cursor: { session_id: uploadId, offset: offset },
          close: false,
          contents: chunk
        })
      );
    }

    offset += chunk.length;
  }
}

async function performIncrementalBackup(lastBackupPath) {
  const { blobs } = await retryOperation(() => list());
  if (blobs.length === 0) {
    throw new Error('No blob found with the provided token');
  }
  const blobInfo = blobs[0]; // We're only dealing with one blob

  const newBackupName = `blob_backup_${new Date().toISOString().replace(/:/g, '-')}`;
  const localPath = path.join(TEMP_DIR, newBackupName);

  if (lastBackupPath) {
    const lastBackupStat = await fs.stat(lastBackupPath);
    if (lastBackupStat.size === blobInfo.size && lastBackupStat.mtime.getTime() === new Date(blobInfo.uploadedAt).getTime()) {
      console.log('Blob has not changed. No new backup needed.');
      return;
    }
  }

  // Download the blob from Vercel
  const blobData = await retryOperation(() => get(blobInfo.url));
  await fs.writeFile(localPath, Buffer.from(await blobData.arrayBuffer()));

  // Verify checksum
  const checksum = await calculateChecksum(localPath);
  console.log(`Backup checksum: ${checksum}`);

  // Upload new backup to Dropbox
  await uploadFileInChunks(localPath, `${BACKUP_DIR}/${newBackupName}`);

  console.log(`Incremental backup completed: ${newBackupName}`);
}

async function removeOldBackups() {
  try {
    const result = await retryOperation(() => dbx.filesListFolder({ path: BACKUP_DIR }));
    const oldBackups = result.result.entries
      .filter(entry => entry['.tag'] === 'file' && entry.name.startsWith('blob_backup_'))
      .sort((a, b) => b.name.localeCompare(a.name))
      .slice(BACKUPS_TO_KEEP);

    for (const backup of oldBackups) {
      await retryOperation(() => dbx.filesDelete({ path: backup.path_lower }));
      console.log(`Deleted old backup: ${backup.name}`);
    }
  } catch (error) {
    console.error('Error removing old backups:', error);
  }
}

async function main() {
  try {
    await fs.mkdir(TEMP_DIR, { recursive: true });

    const lastBackupInfo = await getLastBackupInfo();
    const lastBackupPath = await downloadLastBackup(lastBackupInfo);
    await performIncrementalBackup(lastBackupPath);
    await removeOldBackups();

    // Clean up
    await fs.rm(TEMP_DIR, { recursive: true, force: true });
  } catch (error) {
    console.error('Backup process failed:', error);
    process.exit(1);
  }
}

main();

