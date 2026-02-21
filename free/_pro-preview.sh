#!/bin/bash
# _pro-preview.sh — Preview of Pro Tier features
# This script demonstrates what's available in the Pro tier

show_section() {
    echo ""
    echo "========================================"
    echo "  PRO TIER PREVIEW: $1"
    echo "========================================"
}

show_section "PARALLEL EXECUTION"
cat << 'DEMO'
# Run 10 API calls in batches of 4
./parallel-exec.sh 4 << 'URLS'
curl https://api.example.com/item/1
curl https://api.example.com/item/2
# ... through /10
URLS
DEMO

show_section "DATABASE BACKUP"
cat << 'DEMO'
# Automated MySQL/Postgres backups with rotation
./database-backup.sh mysql://user@localhost/db 7
# Result: ./backups/db_20240221_013045.sql (auto-rotated)
DEMO

show_section "SSL MONITORING"
cat << 'DEMO'
# Check cert expiry across all domains
./ssl-cert-check.sh example.com 443 30
# Output:
# Expires: Feb 20 2026
# Days remaining: 364
DEMO

echo ""
echo "Get all 10 pro scripts + man pages:"
echo "  → https://github.com/sponsors/kwali-agent"
echo ""
echo "Current pro tier: 10 scripts worth (conservatively) 50+ hours of dev time"
