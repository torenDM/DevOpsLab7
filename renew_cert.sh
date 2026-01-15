#!/usr/bin/env bash
set -euo pipefail

CERT_DIR="$(cd "$(dirname "$0")" && pwd)/certs"
CONTAINER="nginx-cont"

echo "[1/2] Re-generate self-signed certificate..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "${CERT_DIR}/server.key" \
  -out   "${CERT_DIR}/server.crt" \
  -subj "/C=RU/ST=Perm/L=Perm/O=DevOpsLab7/OU=IT/CN=localhost" >/dev/null 2>&1

echo "[2/2] Reload nginx inside container..."
docker exec "$CONTAINER" nginx -s reload

echo "Done."
