#!/bin/bash
# extract-any.sh — Universal archive extractor
FILE="$1"
[ -f "$FILE" ] || { echo "Usage: $0 <archive>"; exit 1; }
case "$FILE" in
  *.tar.bz2|*.tbz2) tar -xjf "$FILE" ;;
  *.tar.gz|*.tgz) tar -xzf "$FILE" ;;
  *.tar.xz) tar -xJf "$FILE" ;;
  *.zip) unzip "$FILE" ;;
  *.rar) unrar x "$FILE" ;;
  *.7z) 7z x "$FILE" ;;
  *) echo "Unknown: $FILE" ;;
esac
echo "✓ $FILE extracted"
