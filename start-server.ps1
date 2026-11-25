#!/usr/bin/env pwsh
# PowerShell helper to start the unlimited LLM server
# Usage: .\start-server.ps1

Write-Host "🚀 Starting Unlimited LLM Server..."
# Ensure Docker is installed
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "Docker is not installed. Please install Docker Desktop first."
    exit 1
}

# Pull any updated images and start compose
docker compose up -d
if ($LASTEXITCODE -ne 0) {
    Write-Error "docker compose failed. Check Docker Desktop is running."
    exit $LASTEXITCODE
}

Write-Host "✅ Services are up. LLM API: http://localhost:8000"
Write-Host "✅ UI (optional) at: http://localhost:3000"
