reikop/llama-cpp-py-gpu

## Environment Variables
```
docker run -d \
    --gpus=all \
    --name llama-cpp-python \
    --cap-add SYS_RESOURCE \
    -e HOST=0.0.0.0 \
    -e USE_MLOCK=0 \
    -e MODEL="/app/functionary-small-v2.4-GGUF/functionary-small-v2.4.f16.gguf" \
    -e HF_PRETRAINED_MODEL_NAME_OR_PATH="/app/functionary-small-v2.4-GGUF" \
    -e CHAT_FORMAT="functionary-v2" \
    -v /your/model/path/:/app \
    -p 8000:8000/tcp \
    reikop/llama-cpp-py-gpu
```


## Docker Compose
```yaml
version: '3.8'

services:
  llama-cpp-python:
    image: reikop/llama-cpp-py-gpu
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              capabilities: [gpu]
    container_name: llama-cpp-python
    cap_add:
      - SYS_RESOURCE
    environment:
      - HOST=0.0.0.0
      - USE_MLOCK=0
      - MODEL=/app/functionary-small-v2.4-GGUF/functionary-small-v2.4.f16.gguf
      - HF_PRETRAINED_MODEL_NAME_OR_PATH=/app/functionary-small-v2.4-GGUF
      - CHAT_FORMAT=functionary-v2
    volumes:
      - /your/model/path/:/app
    ports:
      - "8000:8000"
    restart: always
```
    