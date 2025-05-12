#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title routes
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName routes

myserver=10.10.10.2

if (netstat -nr -f inet | grep ^default | grep tun); then
    sudo route delete $myserver
    if (ifconfig en6 | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2 | grep "${myserver%${myserver##*.}}"); then
        sudo route add -host $myserver -interface en6
    elif (ifconfig en0 | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2 | grep "${myserver%${myserver##*.}}"); then
        sudo route add -host $myserver -interface en0
    fi
else
    sudo route delete $myserver
fi
