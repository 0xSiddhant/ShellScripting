#!/bin/bash

LAST_CLIP=""

while sleep 1; do
    # Get current clipboard content
    CURRENT_CLIP=$(pbpaste)

    # If clipboard hasn't changed, skip
    if [[ "$CURRENT_CLIP" == "$LAST_CLIP" ]]; then continue; fi
    LAST_CLIP="$CURRENT_CLIP"

    # Check if it looks like a JWT (starts with eyJ...)
    if [[ "$CURRENT_CLIP" == eyJ* ]]; then
        
        # Decode the middle part (Payload) using Python
        # JWT format: Header.Payload.Signature
        PAYLOAD=$(echo "$CURRENT_CLIP" | cut -d "." -f 2 | base64 -D 2>/dev/null)
        
        if [[ -n "$PAYLOAD" ]]; then
            # Extract specific fields (e.g., 'sub' or 'exp') logic here if needed
            echo "🕵️ JWT Detected!"
            
            # Send Notification with the decoded JSON
            osascript -e "display notification \"$PAYLOAD\" with title \"JWT Decoded\""
        fi
    fi
done