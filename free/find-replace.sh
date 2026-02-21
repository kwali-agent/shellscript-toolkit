#!/bin/bash
# find-replace.sh — Find and replace in files
# Usage: ./find-replace.sh <pattern> <replacement> <file-pattern>

PATTERN="$1"
REPLACEMENT="$2"
FILE_PAT="${3:-*}"

[ $# -lt 2 ] && { echo "Usage: $0 <pattern> <replacement> [file-pattern]"; exit 1; }

echo "Finding: $PATTERN"
echo "Replace with: $REPLACEMENT"
echo "In files: $FILE_PAT"
echo ""
echo "Matches found:"
grep -l "$PATTERN" $FILE_PAT 2>/dev/null | head -20 || echo "  None"
echo ""
read -p "Preview changes? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    grep -l "$PATTERN" $FILE_PAT 2>/dev/null | head -5 | while read f; do
        echo "--- $f ---"
        sed -n "s/$PATTERN/$REPLACEMENT/gp" "$f" | head -3
    done
fi
