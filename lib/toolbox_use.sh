#!/bin/bash

# 1. Source the library
# (Check if it exists first to prevent ugly errors)
if [[ -f "toolbox.sh" ]]; then
    source toolbox.sh
else
    echo "Error: toolbox.sh not found."
    exit 1
fi

# 2. Use the safety checks
# require_root  # Uncomment if you need sudo
require_command "curl"
require_command "git"

# 3. Main Logic
log_info "Welcome to the Deployment Script."

# Ask user for permission
if confirm "Are you sure you want to update the system?"; then
    log_info "Starting update..."
    
    # Simulate work
    sleep 1
    
    # Use the backup tool
    backup_file "my_config.txt"
    
    log_success "System update complete."
else
    log_warn "Update cancelled by user."
    exit 0
fi