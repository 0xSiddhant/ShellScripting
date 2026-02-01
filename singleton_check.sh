#!/bin/bash

# Get the name of the current script
SCRIPT_NAME=$0

# Check if process is already running
# $$ is the PID of the CURRENT script (we want to ignore it)
# pgrep -f checks the full command line name
# grep -v "$$" => Show me all PID that does NOT match to $$ -> current script
if pgrep -f "$SCRIPT_NAME" | grep -v "$$" > /dev/null; then
    echo "⚠️  $SCRIPT_NAME is already running. Exiting."
    exit 1
fi

echo "🚀 Starting Singleton Script..."
# ... Your code here ...
sleep 10