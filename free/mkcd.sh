#!/bin/bash
# mkcd.sh — Create directory and cd into it
# Usage: mkcd new-project (sources mkcd function)

mkcd() {
    mkdir -p "$1" && cd "$1"
}

# If sourced, define function. If executed, use first arg.
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    # Executed directly
    [ $# -eq 0 ] && { echo "Usage: source mkcd.sh && mkcd <dir>"; exit 1; }
    mkcd "$1"
else
    # Sourced
    echo "mkcd() function defined. Use: mkcd <directory>"
fi
