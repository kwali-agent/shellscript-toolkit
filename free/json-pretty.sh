#!/bin/bash
# json-pretty.sh — Pretty print JSON without jq
[ $# -eq 0 ] && { echo "Usage: $0 <file.json>"; exit 1; }
python3 -m json.tool "$1" 2>/dev/null || python -m json.tool "$1" 2>/dev/null || cat "$1"
