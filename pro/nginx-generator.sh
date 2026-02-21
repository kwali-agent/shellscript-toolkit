#!/bin/bash
# nginx-generator.sh — Generate nginx configs for common setups
# Usage: ./nginx-generator.sh --domain example.com --app-port 3000

DOMAIN=""
APP_PORT=""
SSL="false"

while [ $# -gt 0 ]; do
  case "$1" in
    --domain) DOMAIN="$2"; shift ;;
    --app-port) APP_PORT="$2"; shift ;;
    --ssl) SSL="true" ;;
  esac
  shift
done

[ -z "$DOMAIN" ] || [ -z "$APP_PORT" ] && {
  echo "Usage: $0 --domain <domain> --app-port <port> [--ssl]"
  exit 1
}

cat << EOF
server {
    listen 80;
    server_name $DOMAIN;
    
    location / {
        proxy_pass http://localhost:$APP_PORT;
        proxy_http_version 1.1;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
EOF

[ "$SSL" = "true" ] && cat << EOF
    
    # SSL configuration
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
EOF

cat << EOF
}
EOF

