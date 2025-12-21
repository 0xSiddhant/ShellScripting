#!/bin/bash
log_success() {
    local val
    if [[ -t 0 ]]; then
        # no pipe → argument
        val="$1"
    else
        # piped input
        read -r val
    fi
    echo -e "\033[0;32m[SUCCESS]\033[0m $val"
}

log_error() {
    local val
    if [[ -t 0 ]]; then
        # no pipe → argument
        val="$1"
    else
        # piped input
        read -r val
    fi
    echo -e "\033[0;31m[ERROR]\033[0m $val"
}
