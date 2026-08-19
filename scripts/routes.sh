#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title routes
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName routes

target_host="10.10.10.2"

/usr/bin/sudo -n /sbin/route -n delete -host "$target_host" || true

if /usr/sbin/netstat -nr -f inet | /usr/bin/awk '$1 == "default" && $4 ~ /^(tun|utun)/ { found = 1 } END { exit found ? 0 : 1 }'; then
  for iface in en10 en0; do
    if /sbin/ifconfig "$iface" | /usr/bin/awk '/status: active/ { active = 1 } /inet 10\.10\.10\./ { ip = 1 } END { exit !(active && ip) }'; then
      /usr/bin/sudo -n /sbin/route -n add -host "$target_host" -interface "$iface"
      break
    fi
  done
fi