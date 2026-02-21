#!/bin/bash
# git-release.sh — Automate semantic versioning releases
# Usage: ./git-release.sh patch|minor|major

TYPE="${1:-patch}"
[ "$TYPE" != "patch" ] && [ "$TYPE" != "minor" ] && [ "$TYPE" != "major" ] && {
    echo "Usage: $0 [patch|minor|major]";
    exit 1;
}

# Check for uncommitted changes
git diff --quiet --cached || {
    echo "Error: Staged changes exist. Commit first."
    exit 1
}

# Get current version
CURRENT=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
CURRENT=${CURRENT#v}
MAJOR=$(echo "$CURRENT" | cut -d. -f1)
MINOR=$(echo "$CURRENT" | cut -d. -f2)
PATCH=$(echo "$CURRENT" | cut -d. -f3)

# Bump version
case "$TYPE" in
    major) MAJOR=$((MAJOR + 1)); MINOR=0; PATCH=0 ;;
    minor) MINOR=$((MINOR + 1)); PATCH=0 ;;
    patch) PATCH=$((PATCH + 1)) ;;
esac

NEW_VERSION="v${MAJOR}.${MINOR}.${PATCH}"

echo "Current: v$CURRENT → New: $NEW_VERSION"
read -p "Create release? (y/n) " -n 1 -r
echo

[[ ! $REPLY =~ ^[Yy]$ ]] && { echo "Aborted"; exit 0; }

# Create tag and push
git tag -a "$NEW_VERSION" -m "Release $NEW_VERSION"
git push origin "$NEW_VERSION"

echo "✓ Released $NEW_VERSION"
echo "  GitHub release page will auto-generate"
