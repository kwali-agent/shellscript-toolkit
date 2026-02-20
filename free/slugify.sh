#!/bin/bash
# slugify.sh — Convert any string to URL-safe format
# Usage: ./slugify.sh "Some String!"

set -euo pipefail

if [ $# -eq 0 ]; then
    echo "Usage: $0 <string>" >&2
    echo "Example: $0 'Hello World!' => hello-world" >&2
    exit 1
fi

echo "$*" | \
    tr '[:upper:]' '[:lower:]' | \
    tr -c '[:alnum:]' '-' | \
    tr -s '-' | \
    sed 's/^-//;s/-$//'
