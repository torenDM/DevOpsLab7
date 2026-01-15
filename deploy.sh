#!/usr/bin/env bash
set -euo pipefail

IMAGE="nginx-server"
CONTAINER="nginx-cont"
PORT="54321"

cd "$(dirname "$0")"

docker build -t "$IMAGE" ./nginx -f ./nginx/dockerfile

docker rm -f "$CONTAINER" 2>/dev/null || true
docker run -d --name "$CONTAINER" -p "${PORT}:80" --restart unless-stopped "$IMAGE"

docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo
echo "Open: http://127.0.0.1:${PORT}"
