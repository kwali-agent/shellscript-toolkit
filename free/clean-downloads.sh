#!/bin/bash
# clean-downloads.sh — Clean old files from Downloads
DAYS="${1:-30}"
DIR="${DL_DIR:-$HOME/Downloads}"
echo "Files >$DAYS days in $DIR:"
find "$DIR" -type f -mtime +"$DAYS" -ls 2>/dev/null | head -10
echo "Run with DELETE=1 $0 $DAYS to actually delete"
[ "${DELETE:-}" = "1" ] && find "$DIR" -type f -mtime +"$DAYS" -delete && echo "✓ Deleted"
