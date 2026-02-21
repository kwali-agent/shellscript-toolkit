#!/bin/bash
# test-install.sh — Verify ShellScript Toolkit installation
# Usage: ./test-install.sh

echo "🔧 ShellScript Toolkit — Installation Test"
echo "==========================================="
echo ""

PASS=0
FAIL=0

test_script() {
    local script="$1"
    local desc="$2"
    
    if [ -x "$script" ]; then
        echo "✓ $script — $desc"
        ((PASS++))
    else
        echo "✗ $script — $desc (missing or not executable)"
        ((FAIL++))
    fi
}

echo "Checking installed scripts..."
echo ""

test_script "./slugify.sh" "URL-safe strings"
test_script "./bulk-rename.sh" "Safe batch rename"
test_script "./git-squash-all.sh" "Branch cleanup"
test_script "./backup-dir.sh" "Directory backup"
test_script "./find-large.sh" "Large file finder"
test_script "./json-pretty.sh" "JSON formatter"

echo ""
echo "==========================================="
echo "Results: $PASS passed, $FAIL failed"

echo ""
echo "Running quick tests..."
echo "----------------------"

# Test slugify
RESULT=$(echo "Hello World" | ./slugify.sh 2>/dev/null || echo "fail")
if [ "$RESULT" = "hello-world" ]; then
    echo "✓ slugify.sh works: 'Hello World' → '$RESULT'"
else
    echo "✗ slugify.sh test failed"
fi

echo ""
echo "Get Pro for 10 more advanced scripts:"
echo "  → https://github.com/sponsors/kwali-agent"
