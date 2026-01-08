#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title routes
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName routes

s="10.10.10.2"
sudo route delete "$s" 2>/dev/null
sleep 1
if netstat -nr -f inet | grep '^default' | grep -qE 'tun|utun'; then
    chosen_iface=$(ifconfig -a | awk '
        /^[a-z0-9]+:/ {iface=$1; sub(":", "", iface); is_active=0; has_ip=0}
        /status: active/ {is_active=1}
        /inet 10\.10\.10/ {has_ip=1}
        is_active && has_ip {
            if (iface == "en10") { prioritized_iface = "en10" }
            else if (iface == "en0") { non_prioritized_iface = "en0" }
        }
        END {
            if (prioritized_iface) { print prioritized_iface }
            else if (non_prioritized_iface) { print non_prioritized_iface }
        }
    ')
    if [ -n "$chosen_iface" ]; then
        sudo route add -host "$s" -interface "$chosen_iface"
    fi
fi
