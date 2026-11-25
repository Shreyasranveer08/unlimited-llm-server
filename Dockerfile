# Dockerfile for unlimited-llm-server
# Builds llama.cpp server (CPU‑only) and provides an optional CUDA variant.

# ---------- Builder stage ----------
FROM alpine:3.20 AS builder
RUN apk add --no-cache git cmake make gcc g++ musl-dev linux-headers

# Clone llama.cpp (lightweight fork) and build the server binary
RUN git clone https://github.com/ggerganov/llama.cpp.git /src && \
    cd /src && \
    mkdir build && cd build && \
    cmake .. -DLLAMA_BUILD_SERVER=ON && \
    make -j$(nproc)

# ---------- Runtime stage ----------
FROM alpine:3.20
# Add ca‑certificates for HTTPS requests (optional)
RUN apk add --no-cache ca-certificates && update-ca-certificates

COPY --from=builder /src/build/llama-server /app/llama-server
WORKDIR /app
EXPOSE 8000

# Environment variables can be overridden at runtime
ENV MODEL_PATH=/app/models/your-model.gguf
ENV HOST=0.0.0.0
ENV PORT=8000

# Default command runs the server with a reasonable context size
CMD ["./llama-server", "-m", "$MODEL_PATH", "-c", "2048", "-h", "$HOST", "-p", "$PORT"]
