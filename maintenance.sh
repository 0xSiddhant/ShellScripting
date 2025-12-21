#!/bin/bash

# Requirements
# Strict Safety: The script must start with "Strict Mode" flags (-euo pipefail) so it fails fast if there are errors.
# Library Loading: It must source the toolbox.sh file we created earlier.
# Constraint: If toolbox.sh is missing, the script must print a friendly error and exit.
# Root Access: Use the require_root function from the toolbox to ensure only the admin can run it.

# Task A: Disk Cleanup:
# Check if the disk usage of / is above 80%.
# IF it is high: Delete all files inside /tmp/ (Use a dummy folder like ./tmp_test for safety while testing).
# Log a warning if disk usage is high, and a success message after cleaning.

# Task B: Log Rotation:
# Loop through all .log files in a specific directory (create a ./logs_test folder).
# If a file is larger than 1KB (keep it small for testing), compress it using gzip.
# Rename it to filename.log.old.gz.

# Task C: Service Check:
# Check if a dummy service (e.g., nginx or just a variable named SERVICE="cron") is active.
# If it is not running, attempt to start it (using systemctl or just a dummy echo "Starting..." for testing).

# ------------------------------------------------------------------------

# Create dummy directories
(
    mkdir -p ./tmp_test
    mkdir -p ./logs_test

    # Create dummy large log files
    echo "This is a big log file..." > ./logs_test/app.log
    for i in {1..1000}; do echo "filling space" >> ./logs_test/app.log; done
)


# MAIN CODE

set -e
set -o pipefail
set -u

# --- 2. CONFIGURATION ---
TOOLBOX_PATH="lib/toolbox.sh"
TEMP_DIR="./tmp_test"      # Using the test directory we created
LOG_DIR="./logs_test"      # Using the test directory we created

if [[ -f "$TOOLBOX_PATH" ]]; then
    source $TOOLBOX_PATH
else
    echo "Failed to load $TOOLBOX_PATH"
    exit 1
fi

require_root

log_info "Starting Daily System Maintenance..."

# --- TASK A: DISK CLEANUP ---
log_info "Checking Disk Usage..."


# --- TASK B: LOG ROTATION ---
if [[ -d $LOG_DIR ]]; then
    # 'nullglob' ensures the loop doesn't run if no *.log files exist
    shopt -s nullglob

    for logfile in "$LOG_DIR"/*.log; do
        SIZE=$(wc -c < "$logfile")

        if [[ "$SIZE" -gt 1024 ]]; then
            log_info "Rotating $logfile (Size: $SIZE bytes)..."
            
            # Compress the file
            gzip "$logfile"
            
            # Rename .log.gz to .log.old.gz
            mv "${logfile}.gz" "${logfile}.old.gz"
            
            log_success "Rotated to ${logfile}.old.gz"
        fi
    done
    shopt -u nullglob # Reset behavior
else
    log_error "Log directory $LOG_DIR does not exist."
fi
