#!/bin/bash
# api-test.sh — Quick API endpoint testing with curl
# Usage: ./api-test.sh GET https://api.example.com/users

METHOD="${1:-GET}"
URL="$2"
HEADERS="${3:-}"

check_status() {
    local code="$1"
    case "$code" in
        200) echo "OK" ;;
        201) echo "Created" ;;
        204) echo "No Content" ;;
        301) echo "Moved Permanently" ;;
        400) echo "Bad Request" ;;
        401) echo "Unauthorized" ;;
        403) echo "Forbidden" ;;
        404) echo "Not Found" ;;
        500) echo "Server Error" ;;
        *) echo "Unknown ($code)" ;;
    esac
}

[ -z "$URL" ] && { echo "Usage: $0 <METHOD> <URL> [headers]"; exit 1; }

echo "Testing: $METHOD $URL"
echo "=========================================="

# Capture both headers and body
RESPONSE=$(curl -s -w "\n%{http_code}\n%{time_total}\n" \
    -X "$METHOD" \
    -H "Accept: application/json" \
    ${HEADERS:+-H "$HEADERS"} \
    "$URL")

HTTP_CODE=$(echo "$RESPONSE" | tail -2 | head -1)
TIME=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | head -n -2)

echo "Status: $HTTP_CODE ($(check_status "$HTTP_CODE"))"
echo "Time: ${TIME}s"
echo ""
echo "Response:"
echo "$BODY" | head -20
