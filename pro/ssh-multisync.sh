#!/bin/bash
# ssh-multisync.sh — Sync files to multiple servers via SSH in parallel
# Usage: ./ssh-multisync.sh /local/path user@host1,user@host2:/remote

LOCAL_PATH="$1"
SERVER_LIST="$2"
MAX_PARALLEL="${3:-3}"

if [ -z "$LOCAL_PATH" ] || [ -z "$SERVER_LIST" ]; then
    echo "Usage: $0 <local-path> <server1,user@host2:remote>"
    echo "  $0 ./build www1:app,www2:app"
    exit 1
fi

# Split servers and deploy
IFS=',' read -ra SERVERS <<< "$SERVER_LIST"

echo "Deploying $LOCAL_PATH to ${#SERVERS[@]} servers..."

for server in "${SERVERS[@]}"; do
    while [ $(jobs -r | wc -l) -ge "$MAX_PARALLEL" ]; do
        sleep 0.5
    done
    
    echo "→ $server"
    rsync -avz --delete "$LOCAL_PATH" "$server" &
done

wait
echo "✓ Deploy completed"
