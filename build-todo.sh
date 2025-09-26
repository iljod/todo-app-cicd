#!/bin/bash
set -euo pipefail

echo "=== Todo App Build Process ==="

docker stop todo-running 2>/dev/null || true
docker rm todo-running 2>/dev/null || true

docker rmi todo-app:latest 2>/dev/null || true

echo "Building todo-app Docker image..."
docker build -t todo-app:latest .

echo "Starting todo application..."
docker run -d \
  --name todo-running \
  -p 3000:3000 \
  --restart unless-stopped \
  todo-app:latest

echo "Application available at: http://192.168.56.20:3000"
