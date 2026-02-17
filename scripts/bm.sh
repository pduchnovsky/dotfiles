#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title bm restart
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName bm

killall BetterMouse
sleep 1
open -a BetterMouse
