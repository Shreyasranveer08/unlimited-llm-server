# Unlimited Free Token LLM Server

A **one‑click** Docker‑Compose setup that runs an open‑source LLM locally and gives you **unlimited tokens** (the only limit is your own hardware).

## Features
- OpenAI‑compatible `/v1/chat/completions` endpoint (no rate limits).
- Works on CPU‑only machines (7 B model fits ~16 GB RAM).
- Optional GPU‑accelerated image (CUDA) for faster generation.
- One‑line start: `docker compose up -d`.
- Live demo UI (React) on `http://localhost:3000`.

## Quick Start (Windows PowerShell)
```powershell
# 1️⃣ Install Docker Desktop (https://www.docker.com/products/docker-desktop)
# 2️⃣ Clone this repo
git clone https://github.com/your-user/unlimited-llm-server.git
cd unlimited-llm-server
# 3️⃣ Download a model (e.g., Mistral‑7B‑Instruct‑gguf) and place it in the `models/` folder.
# 4️⃣ Start the services
docker compose up -d
# 5️⃣ Test the API
curl http://localhost:8000/v1/chat/completions -H "Content-Type: application/json" -d '{"model":"local","messages":[{"role":"user","content":"Hello!"}]}'
```

## Repository Layout
```
unlimited-llm-server/
├─ docker-compose.yml
├─ Dockerfile          # builds the llama.cpp server
├─ models/            # place *.gguf model files here
├─ ui/                # React demo (optional)
├─ start-server.ps1   # PowerShell helper
├─ start-server.sh    # Linux/macOS helper
└─ README.md
```

## License
MIT – feel free to fork, modify, and publish your own instance.
