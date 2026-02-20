#!/bin/bash
# bulk-rename.sh — Safely rename files in bulk with undo log
# Usage: ./bulk-rename.sh '*.txt' .md

set -euo pipefail

if [ $# -lt 2 ]; then
    echo "Usage: $0 <pattern> <new_extension>"
    echo "  $0 '*.txt' .md       # foo.txt -> foo.md"
    echo "  $0 '*.JPEG' .jpg     # case sensitive replace"
    exit 1
fi

PATTERN="$1"
NEW_EXT="$2"
UNDO_LOG=".bulk-rename-$(date +%s).log"
COUNT=0

for file in $PATTERN; do
    [ -f "$file" ] || continue
    base="${file%.[^.]*}"
    newname="${base}${NEW_EXT}"
    
    if [ "$file" != "$newname" ]; then
        echo "$file" > "$UNDO_LOG"
        mv "$file" "$newname"
        echo "Renamed: $file → $newname"
        ((COUNT++))
    fi
done

echo "Done. $COUNT files renamed. Undo log: $UNDO_LOG"
