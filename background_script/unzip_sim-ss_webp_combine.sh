#!/bin/bash

# --- Configuration ---
LOGfile="/tmp/automation_hub.log"

# function to log with timestamp
log() { echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOGfile"; }

# ==============================================================================
# TASK 1: Simulator Screenshot Mover
# ==============================================================================
move_screenshots() {
    SRC="$HOME/Desktop"
    DEST="$HOME/Pictures/AppScreenshots"
    mkdir -p "$DEST"
    
    # Check for files
    find "$SRC" -maxdepth 1 -name "Simulator Screen Shot*.png" | while read file; do
        mv "$file" "$DEST/"
        log "📱 Moved Screenshot: $(basename "$file")"
        osascript -e 'display notification "Moved Simulator Screenshot" with title "Automation Hub"'
    done
}

# ==============================================================================
# TASK 2: Auto Unzipper
# ==============================================================================
auto_unzip() {
    SRC="$HOME/Downloads"
    cd "$SRC" || return
    
    find . -maxdepth 1 -name "*.zip" | while read zipfile; do
        # Safety check: Is it still downloading?
        if lsof "$zipfile" > /dev/null; then continue; fi
        
        dirname=$(basename "$zipfile" .zip)
        unzip -q -o "$zipfile" -d "$dirname"
        
        if [[ $? -eq 0 ]]; then
            mv "$zipfile" "$HOME/.Trash/"
            log "📦 Unzipped: $dirname"
            osascript -e "display notification \"Unzipped $dirname\" with title \"Automation Hub\""
        fi
    done
}

# ==============================================================================
# TASK 3: WebP Converter
# ==============================================================================
convert_webp() {
    SRC="$HOME/Desktop/ToWebP"
    DEST="$SRC/Done"
    
    if [ ! -d "$SRC" ]; then return; fi # Skip if folder doesn't exist
    mkdir -p "$DEST"
    
    # Check dependency
    if ! command -v cwebp &> /dev/null; then return; fi

    find "$SRC" -maxdepth 1 \( -name "*.png" -o -name "*.jpg" \) | while read img; do
        filename=$(basename "$img")
        name_no_ext="${filename%.*}"
        
        cwebp -q 80 "$img" -o "$DEST/$name_no_ext.webp" > /dev/null 2>&1
        
        if [[ $? -eq 0 ]]; then
            rm "$img"
            log "🖼️ Converted to WebP: $filename"
            osascript -e "display notification \"Converted $filename\" with title \"Automation Hub\""
        fi
    done
}

# ==============================================================================
# EXECUTION
# ==============================================================================
# We run all functions sequentially.
# It is fast because 'find' returns instantly if folders are empty.

move_screenshots
auto_unzip
convert_webp