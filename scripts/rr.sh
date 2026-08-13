#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title raycast restart
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔄
# @raycast.packageName rr

nohup bash <<'EOF' >/dev/null 2>&1 &
lock=/tmp/raycast-restart.lock stamp=/tmp/raycast-restart.last cooldown=8
mkdir "$lock" 2>/dev/null || exit 0
trap 'rmdir "$lock" >/dev/null 2>&1 || true' EXIT
n=$(date +%s) p=$(cat "$stamp" 2>/dev/null || echo 0)
[[ "$p" =~ ^[0-9]+$ ]] && (( n - p < cooldown )) && exit 0
printf '%s\n' "$n" > "$stamp"
osascript -e 'tell application "Raycast" to quit' >/dev/null 2>&1 || true
for _ in {1..15}; do pgrep -x Raycast >/dev/null || break; sleep 0.2; done
pgrep -x Raycast >/dev/null && pkill -9 -x Raycast >/dev/null 2>&1 || true
open -na /Applications/Raycast.app
EOF

exit 0
