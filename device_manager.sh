#!/bin/bash

# --- Function to Boot iOS ---
boot_ios() {
    echo "📱 Fetching available iOS Simulators..."
    
    # --- THE FIX ---
    # 1. Set the Internal Field Separator to Newline (so spaces in names don't break it)
    local IFS=$'\n'
    
    # 2. Fill the array using standard parenthesis
    IOS_DEVICES=( $(xcrun simctl list devices available | grep "iPhone" | grep -v "Shutdown") )
    
    # 3. Fallback if empty
    if [ ${#IOS_DEVICES[@]} -eq 0 ]; then
        echo "No booted devices found. Listing all available..."
        IOS_DEVICES=( $(xcrun simctl list devices available | grep "iPhone") )
    fi
    
    # 4. Reset IFS is not strictly needed because we used 'local', 
    # but the select loop handles array elements correctly now.

    # 5. Select Loop
    PS3="Select an iOS Simulator to boot: "
    select dev_line in "${IOS_DEVICES[@]}" "Cancel"; do
        if [[ "$dev_line" == "Cancel" ]]; then return; fi
        
        if [[ -n "$dev_line" ]]; then
            # Regex to find the UUID: 8-4-4-4-12 hex characters
            if [[ $dev_line =~ ([A-F0-9-]{36}) ]]; then
                UUID="${BASH_REMATCH[1]}"
                echo "🚀 Booting..."
                xcrun simctl boot "$UUID" 2>/dev/null
                open -a Simulator
                break
            else
                echo "❌ Could not parse UUID."
            fi
        else
            echo "Invalid selection."
        fi
    done
}

# --- Function to Boot Android ---
boot_android() {
    echo "🤖 Fetching Android AVDs..."
    
    local IFS=$'\n'
    ANDROID_AVDS=( $(emulator -list-avds) )
    
    if [ ${#ANDROID_AVDS[@]} -eq 0 ]; then
        echo "❌ No Android AVDs found."
        return
    fi

    PS3="Select an Android Emulator to boot: "
    select avd_name in "${ANDROID_AVDS[@]}" "Cancel"; do
        if [[ "$avd_name" == "Cancel" ]]; then return; fi
        
        if [[ -n "$avd_name" ]]; then
            echo "🚀 Launching $avd_name..."
            emulator -avd "$avd_name" > /dev/null 2>&1 &
            break
        else
            echo "Invalid selection."
        fi
    done
}

# --- Main Menu ---
echo "=============================="
echo "   Mobile Device Manager"
echo "=============================="
echo "1) Boot iOS Simulator"
echo "2) Boot Android Emulator"
echo "3) Exit"
read -p "Choose: " CHOICE

case $CHOICE in
    1) boot_ios ;;
    2) boot_android ;;
    *) echo "Bye!" ;;
esac