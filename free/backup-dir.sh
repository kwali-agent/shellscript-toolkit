#!/bin/bash
# backup-dir.sh — Create timestamped backups of any directory
set -euo pipefail
[ $# -eq 0 ] && { echo "Usage: $0 <directory>"; exit 1; }
SOURCE="${1%/}"
BACKUP_BASE="${2:-$HOME/backups}"
[ -d "$SOURCE" ] || { echo "Error: $SOURCE not a directory"; exit 1; }
mkdir -p "$BACKUP_BASE"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BASENAME=$(basename "$SOURCE")
BACKUP_PATH="$BACKUP_BASE/${BASENAME}_${TIMESTAMP}.tar.gz"
tar -czf "$BACKUP_PATH" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")" 2>/dev/null || tar -czf "$BACKUP_PATH" -C "$SOURCE/.." "$(basename "$SOURCE")"
echo "✓ Backup: $BACKUP_PATH ($(du -h "$BACKUP_PATH" | cut -f1))"
