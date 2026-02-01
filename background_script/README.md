# 🚀 LaunchAgent Installation Guide

## Step 1: Prepare the Script

Make sure your script is executable.

```bash
chmod +x ~/your_script.sh
```

## Step 2: Configure pList file

Run this command to auto-replace YOUR_USERNAME with your current user:

```bash
sed -i '' "s/YOUR_USERNAME/$(whoami)/g" com.user.scriptname.plist
```

## Step 3: Install the Agent

Move the configuration file to the User LaunchAgents folder.

```bash
# 1. Move the file
mv com.user.scriptname.plist ~/Library/LaunchAgents/

# 2. Set correct permissions (Critical!)
# The file must be readable by you, but NOT writable by others.
chmod 644 ~/Library/LaunchAgents/com.user.scriptname.plist
```

## Step 4: Activate the Agent

```bash
launchctl load ~/Library/LaunchAgents/com.user.scriptname.plist
```

---

# Maintenance & Troubleshooting

## How to Stop/Uninstall

If you want to stop the script or delete it:

```bash
# 1. Stop the background process
launchctl unload ~/Library/LaunchAgents/com.user.scriptname.plist

# 2. Delete the configuration file (Optional - if removing permanently)
rm ~/Library/LaunchAgents/com.user.scriptname.plist
```

## Check for Errors

If the script isn't working, check the error logs defined in your plist:

```bash
cat /tmp/my_script.err
```
