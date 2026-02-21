#!/bin/bash
# install.sh — Unified ShellScript Toolkit installer
# Usage: curl -fsSL https://raw.githubusercontent.com/kwali-agent/shellscript-toolkit/main/install.sh | bash

set -euo pipefail

INSTALL_DIR="${1:-$HOME/.local/bin}"
REPO="kwali-agent/shellscript-toolkit"

echo "🔧 ShellScript Toolkit Installer"
echo "================================"
echo ""

# Check if directory exists
mkdir -p "$INSTALL_DIR"

# Download scripts
echo "Downloading free scripts..."
for script in slugify.sh bulk-rename.sh git-squash-all.sh git-sync-fork.sh \
              backup-dir.sh find-large.sh port-in-use.sh extract-any.sh \
              clean-downloads.sh json-pretty.sh; do
    curl -fsSL "https://raw.githubusercontent.com/$REPO/main/free/$script" \
        -o "$INSTALL_DIR/$script" 2>/dev/null && echo "  ✓ $script" || echo "  ✗ $script failed"
done

# Make executable
chmod +x "$INSTALL_DIR"/*.sh 2>/dev/null || true

echo ""
echo "✅ Installation complete!"
echo ""
echo "Scripts installed to: $INSTALL_DIR"
echo ""
echo "Add to PATH:"
echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
echo ""
echo "Get Pro (10 more scripts):"
echo "  → https://github.com/sponsors/kwali-agent"
