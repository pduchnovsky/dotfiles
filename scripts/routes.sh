#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title routes
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName routes

s=10.10.10.2
if netstat -nr -f inet | grep ^default | grep -q tun; then
    sudo route delete $s 2>/dev/null
    i=$(ifconfig | awk -v p="${s%.*}" '$1 ~ /^[a-z0-9]+:/ {i=$1; sub(":", "", i)} $1=="inet" && $2 ~ "^"p"." {print i; exit}')
    [ -n "$i" ] && sudo route add -host $s -interface $i
else
    sudo route delete $s 2>/dev/null
fi
