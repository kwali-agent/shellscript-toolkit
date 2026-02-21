#!/bin/bash
# log-analyze.sh — Parse logs and generate traffic stats
# Usage: ./log-analyze.sh access.log [--top-ips --status-codes --hourly]

LOG_FILE="$1"
shift

if [ -z "$LOG_FILE" ]; then
    echo "Usage: $0 <logfile> [options]"
    exit 1
fi

echo "=== Log Analysis: $LOG_FILE ==="
echo ""

# Total requests
TOTAL=$(wc -l < "$LOG_FILE")
echo "Total requests: $TOTAL"

# Top IPs
echo "
Top 10 IPs:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10

# Status codes
echo "
Status code distribution:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn

echo "
✓ Analysis complete"
