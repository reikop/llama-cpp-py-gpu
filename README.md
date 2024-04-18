reikop/llama-cpp-py-gpu

```
docker run -d \
    --gpus=all \
    --name llama-cpp-python \
    --cap-add SYS_RESOURCE \
    -e USE_MLOCK=0 \
    -e MODEL_PATH="/app/functionary-small-v2.4-GGUF/functionary-small-v2.4.f16.gguf" \
    -e HF_PATH="/app/functionary-small-v2.4-GGUF" \
    -e CHAT_FORMAT="functionary-v2" \
    -v /your/model/path/:/app \
    -p 8000:8000/tcp \
    reikop/llama-cpp-py-gpu
```
