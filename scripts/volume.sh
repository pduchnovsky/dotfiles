#!/bin/bash

STATE_FILE="/tmp/rustdesk_prev_vol"
VOL_REMOTE=1

# Function to get current volume
get_vol() {
    osascript -e "output volume of (get volume settings)"
}

# Check for active RustDesk connection
if lsof -i :21116-21119 -sTCP:ESTABLISHED > /dev/null; then
    # If connection exists but we haven't recorded the "Pre-connection" volume yet
    if [ ! -f "$STATE_FILE" ]; then
        CURRENT_VOL=$(get_vol)
        echo "$CURRENT_VOL" > "$STATE_FILE"
        osascript -e "set volume output volume $VOL_REMOTE"
    fi
else
    # No connection. If state file exists, restore volume and delete file
    if [ -f "$STATE_FILE" ]; then
        PREV_VOL=$(cat "$STATE_FILE")
        osascript -e "set volume output volume $PREV_VOL"
        rm "$STATE_FILE"
    fi
fi