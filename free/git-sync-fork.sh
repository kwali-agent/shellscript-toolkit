#!/bin/bash
# git-sync-fork.sh — Sync your fork with upstream
git remote -v | grep -q upstream || {
    echo "No upstream. Add: git remote add upstream <original-repo>"
    exit 1

git checkout main && git fetch upstream && git merge upstream/main && git push origin main
echo "✓ Fork synced"
