#!/bin/bash
# git-squash-all.sh — Squash entire branch into single commit
# Usage: ./git-squash-all.sh "clean commit message"

set -euo pipefail

if [ -z "${1:-}" ]; then
    echo "Usage: $0 \"commit message\""
    exit 1
fi

if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Not a git repository" >&2
    exit 1
fi

git checkout $(git rev-parse --abbrev-ref HEAD) 2>/dev/null
git checkout HEAD~1
git commit --amend -m "$1"

echo "Squashed into single commit: '$1'"
