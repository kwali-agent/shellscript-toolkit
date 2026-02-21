#!/bin/bash
# database-backup.sh — Automated database backups with rotation
# Usage: ./database-backup.sh mysql://user:pass@host/db [retention_days]

DB_URL="$1"
RETENTION="${2:-7}"
BACKUP_DIR="${BACKUP_DIR:-./backups}"

[ -z "$DB_URL" ] && { echo "Usage: $0 <db_url> [retention_days]"; exit 1; }

mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Parse URL (simple: mysql://user:pass@host/db)
PROTO=$(echo "$DB_URL" | cut -d: -f1)
DB_NAME=$(echo "$DB_URL" | rev | cut -d/ -f1 | rev)

echo "Backing up $DB_NAME..."

case "$PROTO" in
  mysql)
    mysqldump "${DB_URL#mysql://}" > "$BACKUP_DIR/${DB_NAME}_${TIMESTAMP}.sql"
    ;;
  postgres|postgresql)
    pg_dump "${DB_URL#postgres*://}" > "$BACKUP_DIR/${DB_NAME}_${TIMESTAMP}.sql"
    ;;
  *)
    echo "Unsupported: $PROTO"
    exit 1
    ;;
esac

# Rotate old backups
echo "Rotating backups >$RETENTION days..."
find "$BACKUP_DIR" -name "${DB_NAME}_*.sql" -mtime +$RETENTION -delete

echo "✓ Backup: $BACKUP_DIR/${DB_NAME}_${TIMESTAMP}.sql"
