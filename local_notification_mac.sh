#!/bin/bash

TITLE="My Script"
MESSAGE="Process completed successfully! 🚀"

# execute AppleScript to show notification
osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" sound name \"default\""

# You can change "default" to other system sounds like "Glass", "Ping", or "Submarine".

osascript -e 'display notification "Task Done" with title "Backup" subtitle "Level 2" sound name "Glass"'

# Notification using JS
osascript -l JavaScript -e "app = Application.currentApplication(); app.includeStandardAdditions = true; app.displayNotification('Hello from JS', {withTitle: 'JXA'});"