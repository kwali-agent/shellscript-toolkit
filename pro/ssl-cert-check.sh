#!/bin/bash
# ssl-cert-check.sh — Check SSL certificate expiry dates
# Usage: ./ssl-cert-check.sh example.com [port]

HOST="$1"
PORT="${2:-443}"
WARN_DAYS="${3:-30}"

[ -z "$HOST" ] && { echo "Usage: $0 <hostname> [port] [warn-days]"; exit 1; }

echo "Checking SSL cert for $HOST:$PORT..."

CERT_INFO=$(echo | openssl s_client -servername "$HOST" -connect "$HOST:$PORT" 2>/dev/null | openssl x509 -noout -dates -subject)

NOT_AFTER=$(echo "$CERT_INFO" | grep notAfter | cut -d= -f2)
EXPIRY_EPOCH=$(date -d "$NOT_AFTER" +%s 2>/dev/null || date -j -f "%b %d %H:%M:%S %Y %Z" "$NOT_AFTER" +%s)
NOW_EPOCH=$(date +%s)
DAYS_UNTIL=$(( (EXPIRY_EPOCH - NOW_EPOCH) / 86400 ))

echo "Expires: $NOT_AFTER"
echo "Days remaining: $DAYS_UNTIL"

[ $DAYS_UNTIL -lt $WARN_DAYS ] && echo "⚠️ WARNING: Expires in $DAYS_UNTIL days!"
[ $DAYS_UNTIL -lt 0 ] && echo "❌ EXPIRED!"

echo "Subject: $(echo "$CERT_INFO" | grep subject= | cut -d= -f2-)"
