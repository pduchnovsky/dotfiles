#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title proxy start
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName start

sudo launchctl load /Library/LaunchDaemons/com.rsa.nwe.agent.daemon.plist
sudo /usr/local/McAfee/Scp/bin/scpcontrol.sh start
