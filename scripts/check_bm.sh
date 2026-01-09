#!/bin/bash
# 1. Get the unique Identifier for the established NoMachine connection
# This looks for the "NAME" column in lsof which contains the local->remote IP mapping
CURRENT_CONN=$(lsof -a -c nxnode -i :4000 | grep "ESTABLISHED" | awk "{print \$2}" | head -n 1)

# 2. Path to our "memory" file
LAST_CONN_FILE="/tmp/bm_last_conn_id"

# 3. If a connection exists
if [ -n "$CURRENT_CONN" ]; then
    # Read the last known connection ID
    LAST_CONN=$(cat "$LAST_CONN_FILE" 2>/dev/null)

    # 4. Compare: If the current ID is different from the last one, it is a NEW session
    if [ "$CURRENT_CONN" != "$LAST_CONN" ]; then
        killall BetterMouse
        sleep 2
        open -a BetterMouse
        
        # Save the new ID so we dont restart again for this same session
        echo "$CURRENT_CONN" > "$LAST_CONN_FILE"
        echo "New NoMachine session detected ($CURRENT_CONN). BetterMouse restarted at $(date)" >> /tmp/bm_script.log
    fi
else
    # If no connection exists, clear the memory file so it is ready for the next login
    rm -f "$LAST_CONN_FILE"
fi
