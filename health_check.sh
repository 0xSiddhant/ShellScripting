#!/bin/bash

# --- CONFIGURATION ---
DISK_THRESHOLD=80
MEM_THRESHOLD=80

# ANSI Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# --- FUNCTIONS ---

check_disk_usage() {
    # This works on both Mac and Linux
    DISK_USAGE=$(df -h / | grep / | awk '{ print $5 }' | sed 's/%//g')
    
    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
        echo -e "${RED}[WARNING] Disk Usage is High: ${DISK_USAGE}%${NC}"
    else
        echo -e "${GREEN}[OK] Disk Usage is Safe: ${DISK_USAGE}%${NC}"
    fi
}

check_mem_usage() {
    # Check OS Type
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # --- macOS LOGIC ---
        # macOS doesn't have 'free'. We use 'top' to get a summary line.
        # Calculating exact % on Mac is complex for a script, so we display the raw status.
        echo -e "Memory Usage (macOS):"
        top -l 1 | head -n 10 | grep "PhysMem"
        
    else
        # --- LINUX LOGIC ---
        # Original logic for Linux systems
        TOTAL_MEM=$(free -m | grep Mem: | awk '{ print $2 }')
        USED_MEM=$(free -m | grep Mem: | awk '{ print $3 }')

        # Check to ensure we didn't get empty data (prevents division by 0)
        if [ -z "$TOTAL_MEM" ] || [ "$TOTAL_MEM" -eq 0 ]; then
             echo -e "${RED}[ERROR] Could not read memory data.${NC}"
             return
        fi

        MEM_PERCENT=$(( 100 * USED_MEM / TOTAL_MEM ))

        if [ "$MEM_PERCENT" -gt "$MEM_THRESHOLD" ]; then
            echo -e "${RED}[WARNING] Memory Usage is High: ${MEM_PERCENT}%${NC}"
        else
            echo -e "${GREEN}[OK] Memory Usage is Safe: ${MEM_PERCENT}%${NC}"
        fi
    fi
}

# --- MAIN EXECUTION ---

echo "----------------------------------"
echo "   SYSTEM HEALTH CHECK REPORT     "
echo "   Date: $(date)"
echo "----------------------------------"

check_disk_usage
echo "" # Empty line for spacing
check_mem_usage

echo "----------------------------------"
echo "   Check Complete."
echo "----------------------------------"