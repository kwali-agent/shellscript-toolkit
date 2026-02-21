#!/bin/bash
# docker-cleanup.sh — Clean unused Docker resources
# Usage: ./docker-cleanup.sh [--dry-run | --force]

MODE="${1:--interactive}"

docker system df

case "$MODE" in
  --dry-run|-n)
    echo "Would remove:"
    docker images -f "dangling=true" -q | wc -l | xargs echo "  Dangling images:"
    docker ps -f "status=exited" -q | wc -l | xargs echo "  Exited containers:"
    docker volume ls -f "dangling=true" -q | wc -l | xargs echo "  Dangling volumes:"
    ;;
  --force|-f)
    echo "Removing unused resources..."
    docker system prune -af --volumes
    ;;
  *)
    echo "This will remove:"
    docker system df
    read -p "Continue? (y/n) " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] && docker system prune -af --volumes
    ;;
esac
