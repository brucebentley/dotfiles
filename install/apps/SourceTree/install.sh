#!/usr/bin/env bash

BASE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
INSTALL_DIR="/usr/local/bin"
PREFIX="source_tree_"
SOURCETREE_DIR="$HOME/Library/Application Support/SourceTree"
NOW=$(date '+%Y-%m-%d_%H.%M.%S')


echo "Base directory is: ""$BASE_PATH"

# Change Permission For All The Shell Scripts In The bin Folder
chmod -R -v a+rwx "$BASE_PATH"/bin/*.sh

for filepath in "$BASE_PATH"/bin/*.sh; do
    filename=$(basename "$filepath" .sh)
    ln -fs "$filepath" $INSTALL_DIR/source_tree_"$filename"
done

echo "Created symbolic links:"
ls $INSTALL_DIR/source_tree_*

# Make A Backup
mkdir actions_backups
cp "$SOURCETREE_DIR/actions.plist" "actions_backups/$NOW.plist"

# Update Custom Actions
cp actions.plist "$SOURCETREE_DIR/actions.plist"
