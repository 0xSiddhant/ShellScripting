#!/bin/bash

LOCK_DIR="$(pwd)/locks"
if [[ ! -d $LOCK_DIR ]]; then
    mkdir $LOCK_DIR
fi
LOCK_FILE="$LOCK_DIR/my_script.lock"

# 1. Check if lock file exists
if [[ -f "$LOCK_FILE" ]]; then
    # Read the PID from the file
    PID=$(cat "$LOCK_FILE")
    
    # Check if that PID is actually still running
    if ps -p "$PID" > /dev/null; then
        echo "❌ Script is already running (PID: $PID). Exiting."
        exit 1
    else
        echo "⚠️  Found stale lock file (Previous crash?). Removing it."
        rm "$LOCK_FILE"
    fi
fi

# 2. Create new lock file with current PID ($$)
echo $$ > "$LOCK_FILE"

# 3. Ensure lock file is removed when script exits (even if it crashes!)
trap 'rm -f "$LOCK_FILE"; exit' EXIT

# --- MAIN LOGIC ---
echo "✅ Script started (PID: $$)"
echo "Working..."
sleep 20
echo "Done."