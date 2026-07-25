#!/bin/bash
# restore.sh - Restores essential account and configuration directories from a tarball.

if [ -z "$1" ]; then
  echo "Usage: ./restore.sh <path_to_backup.tar.gz>"
  exit 1
fi

BACKUP_FILE="$1"

# Resolve absolute path of backup file in case the script is run from a different directory
BACKUP_FILE_ABS=$(readlink -f "$BACKUP_FILE")

if [ ! -f "$BACKUP_FILE_ABS" ]; then
  echo "Error: Backup file '$BACKUP_FILE_ABS' not found."
  exit 1
fi

echo "Restoring from $BACKUP_FILE_ABS..."

# Extract the tarball into the user's home directory
# Since we packaged them with relative paths (e.g. .config/google-chrome), 
# they will overwrite the existing directories inside $HOME.
tar -xzvf "$BACKUP_FILE_ABS" -C "$HOME"

echo "=========================================="
echo "Restore complete!"
echo "Please log out of Ubuntu and log back in, or restart your computer, so the OS can load the restored keyrings."
