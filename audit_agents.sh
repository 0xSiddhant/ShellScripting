#!/bin/bash

# Define the two locations where 3rd party agents live
USER_AGENTS="$HOME/Library/LaunchAgents"
GLOBAL_AGENTS="/Library/LaunchAgents"

echo "=========================================="
echo "🕵️  SEARCHING FOR 3RD PARTY LAUNCH AGENTS"
echo "=========================================="

# Function to list agents
list_agents() {
    local DIR=$1
    local LABEL=$2
    
    echo ""
    echo "📂 LOCATION: $LABEL"
    echo "   ($DIR)"
    echo "------------------------------------------"
    
    # Check if dir exists
    if [ ! -d "$DIR" ]; then
        echo "   (Directory empty or not found)"
        return
    fi
    
    # Enable nullglob so loop doesn't run if no matches
    shopt -s nullglob
    
    count=0
    for file in "$DIR"/*.plist; do
        filename=$(basename "$file")
        
        # Filter out Apple internal stuff (rare in these folders, but good safety)
        if [[ "$filename" == com.apple.* ]]; then
            continue
        fi
        
        echo "   🔴 $filename"
        ((count++))
    done
    
    if [ $count -eq 0 ]; then
        echo "   ✅ Clean! No third-party agents found."
    fi
    shopt -u nullglob
}

# 1. Scan User Agents (Safe to delete)
list_agents "$USER_AGENTS" "User Agents (Only affects you)"

# 2. Scan Global Agents (Affects all users)
list_agents "$GLOBAL_AGENTS" "Global Agents (Requires sudo to delete)"

echo ""
echo "=========================================="
echo "💡 To remove an agent:"
echo "   1. launchctl unload <full_path_to_plist>"
echo "   2. rm <full_path_to_plist>"
echo "=========================================="