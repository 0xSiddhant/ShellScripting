#!/bin/bash

# ==========================================
# Function: epoch_to_datetime
# ------------------------------------------
# Description:
#   Converts a given Unix epoch time
#   (in seconds) into a human-readable
#   date-time string in India timezone (IST).
#
# Usage:
#   epoch_to_datetime <epoch_time>
#   echo "<epoch_time>" | epoch_to_datetime
#
# Parameters:
#   $1 - (Required) Unix epoch time in seconds.
#        When using pipe (|), the first field
#        from stdin is treated as epoch time.
#
# Output Format:
#   DD-MM-YYYY hh:mm:ss:AM/PM
#
# Timezone:
#   - Always uses Asia/Kolkata (IST)
#   - Independent of system timezone
#
# Notes:
#   - Works on both macOS and Linux.
#   - On macOS, uses `date -r`.
#   - On Linux, uses `date -d`.
#
# Examples:
#   epoch_to_datetime 1734681600
#   epoch_to_datetime $EPOCHSECONDS
#   echo $EPOCHSECONDS | epoch_to_datetime
#   pbpaste | epoch_to_datetime
# ==========================================
epoch_to_datetime() {
    local tz="Asia/Kolkata"
    local epoch

    if [[ -t 0 ]]; then
        # no pipe → argument
        epoch="$1"
    else
        # piped input
        read -r epoch
    fi

    if date -d "@0" >/dev/null 2>&1; then
        # Linux
        TZ="$tz" date -d "@$epoch" "+%d-%m-%Y %I:%M:%S:%p"
    else
        # macOS
        TZ="$tz" date -r "$epoch" "+%d-%m-%Y %I:%M:%S:%p"
    fi
}

epoch_to_datetime $1



