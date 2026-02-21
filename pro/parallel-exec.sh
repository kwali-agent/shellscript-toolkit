#!/bin/bash
# parallel-exec.sh — Execute commands in parallel with rate limiting
# Usage: cat commands.txt | ./parallel-exec.sh 4

MAX_JOBS="${1:-4}"
trap 'kill $(jobs -p) 2>/dev/null; exit 1' INT TERM

JOB_COUNT=0

echo "Running with max $MAX_JOBS parallel processes..."

while IFS= read -r cmd; do
    [ -z "$cmd" ] && continue
    
    while [ $(jobs -r | wc -l) -ge "$MAX_JOBS" ]; do
        sleep 0.1
    done
    
    echo "[$(date '+%H:%M:%S')] Starting: $cmd" 
    eval "$cmd" &
    ((JOB_COUNT++))
done

wait
echo "Completed $JOB_COUNT jobs"
