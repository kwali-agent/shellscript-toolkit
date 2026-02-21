#!/bin/bash
# env-rotate.sh — Rotate environment files (.env, .env.local, etc.)
# Usage: ./env-rotate.sh

ENV_FILE="${1:-.env}"
BACKUP_DIR="${ENV_BACKUP_DIR:-.env_backups}"
KEEP="${ENV_KEEP_BACKUPS:-5}"

[ -f "$ENV_FILE" ] || { echo "$ENV_FILE not found"; exit 1; }

mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP="$BACKUP_DIR/${ENV_FILE##*/}.${TIMESTAMP}.backup"

cp "$ENV_FILE" "$BACKUP"

# Rotate old backups
ls -t "$BACKUP_DIR/${ENV_FILE##*/}".*.backup 2>/dev/null | tail -n +$((KEEP + 1)) | xargs -r rm

echo "✓ $ENV_FILE backed up to $BACKUP"
echo "  Keeping last $KEEP backups"
echo "  Current backups:"
ls -1 "$BACKUP_DIR"/*backup 2>/dev/null | wc -l | xargs echo "  Count:"
