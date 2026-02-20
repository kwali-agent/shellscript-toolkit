#!/bin/bash
# find-large.sh — Find files larger than X MB
SIZE_MB="${1:-100}"
DIR="${2:-.}"
SIZE_B=$(($SIZE_MB * 1048576))
echo ">${SIZE_MB}MB files in $DIR:"
find "$DIR" -type f -size +"${SIZE_B}c" 2>/dev/null -exec ls -lh {} \; | awk '{print $5": "$9}' | sort -hr | head -20
