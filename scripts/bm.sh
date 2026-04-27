#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle BetterMouse
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖱️
# @raycast.packageName bm

#!/bin/bash

# 1. Check if a NoMachine connection is actually established
# We look for established network connections on the NX port (default 4000)
NX_CONNECTED=$(netstat -atn | grep ESTABLISHED | grep ".4000")

# 2. Check if BetterMouse is running
BM_RUNNING=$(pgrep -x "BetterMouse")

if [ -n "$NX_CONNECTED" ]; then
    # NX is active -> BetterMouse should be OFF
    if [ -n "$BM_RUNNING" ]; then
        killall "BetterMouse"
        echo "NX Active: BetterMouse killed."
    fi
else
    # NX is inactive -> BetterMouse should be ON
    if [ -z "$BM_RUNNING" ]; then
        open -a "BetterMouse"
        echo "NX Inactive: BetterMouse started."
    fi
fi