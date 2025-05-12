#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title proxy stop
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName stop

export BROWSER=""
sudo launchctl unload /Library/LaunchDaemons/com.rsa.nwe.agent.daemon.plist
sudo /usr/local/McAfee/Scp/bin/scpcontrol.sh stop
