#!/bin/bash
# copy.sh - Backs up essential account and configuration directories into a tarball.

BACKUP_FILE="$HOME/account-backup-$(date +%F).tar.gz"
echo "Creating backup tarball: $BACKUP_FILE"

# List of directories to back up. We use relative paths from $HOME to make extraction safe and easy.
DIRECTORIES=(
  ".local/share/keyrings"
  ".config/google-chrome"
  ".config/chromium"
  ".config/BraveSoftware"
  ".config/JetBrains"
  ".local/share/JetBrains"
  ".config/Code"
  ".config/Slack"
  ".config/spotify"
  ".ssh"
  ".aws"
)

# Filter out directories that don't exist so tar doesn't throw errors
EXISTING_DIRS=()
for dir in "${DIRECTORIES[@]}"; do
  if [ -d "$HOME/$dir" ]; then
    EXISTING_DIRS+=("$dir")
    echo "Found $dir"
  else
    echo "Skipping $dir (does not exist)"
  fi
done

if [ ${#EXISTING_DIRS[@]} -eq 0 ]; then
  echo "No directories found to back up."
  exit 1
fi

# Package them into a tarball from the context of the home directory
cd "$HOME" || exit 1
tar --exclude="Singleton*" -czvf "$BACKUP_FILE" "${EXISTING_DIRS[@]}"

echo "=========================================="
echo "Backup complete! File saved to: $BACKUP_FILE"
echo "You can now safely move this file to a USB drive or your OneDrive."
