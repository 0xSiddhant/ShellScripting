#!/bin/bash

# Define paths
DOWNLOADS="$HOME/Downloads"
DESKTOP="$HOME/Desktop"
PROJECTS="$HOME/Projects"

# Watch ALL these paths in one single process
# Instead of creating images_watcher.sh, projects_watcher.sh, and downloads_watcher.sh, you should create one single script that watches multiple paths and routes the logic.
# -r: Recursive (optional, be careful with deep trees)
fswatch -0 --event Created --event MovedTo -e ".*" -i "\\.(png|apk|zip)$" "$DOWNLOADS" "$DESKTOP" "$PROJECTS" | while read -d "" event_file; do

    # Check which folder the event came from
    if [[ "$event_file" == "$DOWNLOADS"* ]]; then
        # Logic for Downloads
        echo "⬇️  Handling Download: $event_file"
        # call function...
        
    elif [[ "$event_file" == "$DESKTOP"* ]]; then
        # Logic for Desktop cleanup
        echo "🖥️  Handling Desktop: $event_file"
        
    elif [[ "$event_file" == "$PROJECTS"* ]]; then
        # Logic for Project syncing
        echo "🔨 Handling Project: $event_file"
    fi
done