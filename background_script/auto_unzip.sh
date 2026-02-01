#!/bin/bash

WATCH_DIR="$HOME/Downloads"

cd "$WATCH_DIR" || exit

# Find zip files
find . -maxdepth 1 -name "*.zip" | while read zipfile; do
    
    # 1. Check if file is completely finished downloading (no lsof lock)
    # (Skip if the system is still writing to it)
    if lsof "$zipfile" > /dev/null; then
        continue
    fi

    filename=$(basename "$zipfile" .zip)
    
    # 2. Unzip into a folder of the same name
    unzip -q "$zipfile" -d "$filename"
    
    if [[ $? -eq 0 ]]; then
        # 3. Move original zip to Trash (using native Mac command)
        mv "$zipfile" "$HOME/.Trash/"
        osascript -e "display notification \"Unzipped $filename\" with title \"📦 Auto-Unzip\""
    fi
done