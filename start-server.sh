#!/usr/bin/env bash
# Bash helper to start the unlimited LLM server (Linux/macOS)
# Usage: ./start-server.sh

set -e

echo "🚀 Starting Unlimited LLM Server..."
# Verify Docker is installed
if ! command -v docker &>/dev/null; then
  echo "Error: Docker is not installed. Please install Docker first." >&2
  exit 1
fi

# Start Docker Compose
docker compose up -d

echo "✅ Services are up. LLM API: http://localhost:8000"
echo "✅ UI (optional) at: http://localhost:3000"
