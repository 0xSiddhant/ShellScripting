#!/bin/bash

# --- 1. CONFIGURATION & COLORS ---
# Variables sourced here are accessible in your main script
LOG_FILE="script.log"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# --- 2. LOGGING FUNCTIONS ---
# Usage: log_info "Starting process..."
log_info() {
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo -e "${BLUE}[INFO]${NC} ${timestamp} - $1"
    # Optional: Log to file as well
    echo "[INFO] ${timestamp} - $1" >> "$LOG_FILE"
}

log_success() {
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo -e "${GREEN}[OK]${NC}   ${timestamp} - $1"
    echo "[OK]   ${timestamp} - $1" >> "$LOG_FILE"
}

log_warn() {
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo -e "${YELLOW}[WARN]${NC} ${timestamp} - $1"
    echo "[WARN] ${timestamp} - $1" >> "$LOG_FILE"
}

log_error() {
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo -e "${RED}[FAIL]${NC} ${timestamp} - $1" >&2 # Send to STDERR
    echo "[FAIL] ${timestamp} - $1" >> "$LOG_FILE"
}

# --- 3. INTERACTION FUNCTIONS ---
# Usage: confirm "Do you want to continue?"
# Returns 0 for Yes, 1 for No
confirm() {
    local prompt="$1"
    while true; do
        read -p "$prompt [y/n]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# --- 4. SAFETY CHECK FUNCTIONS ---
# Usage: require_root
require_root() {
    if [ "$EUID" -ne 0 ]; then
        log_error "This script must be run as root."
        exit 1
    fi
}

# Usage: require_command curl
require_command() {
    local cmd="$1"
    if ! command -v "$cmd" &> /dev/null; then
        log_error "Command '$cmd' is required but not installed."
        exit 1
    fi
}

# --- 5. UTILITY FUNCTIONS ---
# Usage: backup_file "/etc/hosts"
backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        local backup_name="${file}.bak.$(date +%F_%T)"
        cp "$file" "$backup_name"
        log_success "Backed up $file to $backup_name"
    else
        log_warn "File $file does not exist, skipping backup."
    fi
}