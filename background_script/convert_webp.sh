#!/bin/bash

# Create a folder named ~/Desktop/ToWebP. Any image you drop there is automatically converted and moved to ~/Desktop/ToWebP/Done.
# Requires: brew install webp
if ! command -v cwebp &> /dev/null; then exit 1; fi

WATCH_DIR="$HOME/Desktop/ToWebP"
OUTPUT_DIR="$WATCH_DIR/Done"
mkdir -p "$OUTPUT_DIR"

# Convert PNG and JPG
find "$WATCH_DIR" -maxdepth 1 \( -name "*.png" -o -name "*.jpg" \) | while read img; do
    
    filename=$(basename "$img")
    name_no_ext="${filename%.*}"
    
    # Convert
    cwebp -q 80 "$img" -o "$OUTPUT_DIR/$name_no_ext.webp"
    
    if [[ $? -eq 0 ]]; then
        rm "$img" # Delete original (or move to a backup folder)
        osascript -e "display notification \"Converted $filename to WebP\" with title \"🖼️ Converter\""
    fi
done