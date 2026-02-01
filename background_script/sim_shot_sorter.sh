#!/bin/bash

# 1. Define Paths
SOURCE_DIR="$HOME/Desktop"
TARGET_DIR="$HOME/Pictures/AppScreenshots"

# 2. Create target folder if missing
if [[ ! -d "$TARGET_DIR" ]]; then
    mkdir -p "$TARGET_DIR"
fi

# 3. Find and Move Files
# We look for standard iOS Simulator screenshot naming conventions
# "Simulator Screen Shot..."
find "$SOURCE_DIR" -maxdepth 1 -name "Simulator Screen Shot*.png" | while read file; do
    
    # Move the file
    mv "$file" "$TARGET_DIR/"
    
    # Extract filename for notification
    fname=$(basename "$file")
    
    # Notify
    osascript -e "display notification \"Moved $fname\" with title \"📱 Screenshot Filed\""
done