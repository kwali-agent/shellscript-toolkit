#!/bin/bash
# port-in-use.sh — Check what's using a port
[ -z "${1:-}" ] && { echo "Usage: $0 <port>"; exit 1; }
command -v lsof >/dev/null && lsof -i :"$1" 2>/dev/null | head -5 && exit 0
command -v netstat >/dev/null && netstat -tlnp 2>/dev/null | grep ":$1 " | head -3 && exit 0
echo "Run: curl -Is http://localhost:$1"
