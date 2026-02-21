#!/bin/bash
# git-cleanup.sh — Clean git branches and old objects
# Usage: ./git-cleanup.sh [--branches] [--objects] [--force]

SHOW_BRANCHES=false
SHOW_OBJECTS=false
FORCE=false

for arg in "$@"; do
    case "$arg" in
        --branches) SHOW_BRANCHES=true ;;
        --objects) SHOW_OBJECTS=true ;;
        --force) FORCE=true ;;
    esac
done

[ "$SHOW_BRANCHES" = false ] && [ "$SHOW_OBJECTS" = false ] && SHOW_BRANCHES=true

echo "Git Cleanup Tool"
echo "==============="
echo ""

if [ "$SHOW_BRANCHES" = true ]; then
    echo "Merged local branches (not current):"
    git branch --merged | grep -v "^*" || echo "  None found"
    echo ""
    
    REMOTE=$(git remote 2>/dev/null | head -1)
    if [ -n "$REMOTE" ]; then
        echo "Remote-tracking branches (gone from remote):"
        git branch -vv | grep ': gone]' | awk '{print "  " $1}' | head -10
        echo ""
    fi
    
    if [ "$FORCE" = true ]; then
        echo "Removing merged branches..."
        git branch --merged | grep -v "^*" | xargs -r git branch -d
        echo "✓ Branches cleaned"
    else
        echo "Run with --force to delete merged branches"
    fi
fi

if [ "$SHOW_OBJECTS" = true ]; then
    echo "Repository size:"
    du -sh .git 2>/dev/null || echo "  Unable to check"
    echo ""
    echo "Run 'git gc --aggressive' to optimize"
fi
