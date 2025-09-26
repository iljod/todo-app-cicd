```bash
#!/bin/bash
set -euo pipefail

echo "=== Todo App Build Process ==="

docker stop todo-running 2>/dev/null || true
docker rm todo-running 2>/dev/null || true

docker rmi todo-app:latest 2>/dev/null || true

echo "Building todo-app Docker image..."
docker build -t todo-app:latest .

if [ $? -ne 0 ]; then
    echo "Docker build failed!"
    exit 1
fi

echo "Starting todo application..."
docker run -d \
  --name todo-running \
  -p 3000:3000 \
  --restart unless-stopped \
  todo-app:latest

sleep 5

if [ "$(docker inspect -f '{{.State.Running}}' todo-running)" != "true" ]; then
    echo "Container failed to start! Checking logs..."
    docker logs todo-running
    exit 1
fi

echo "Todo app build completed successfully!"
echo "Application available at: http://192.168.56.20:3000"
