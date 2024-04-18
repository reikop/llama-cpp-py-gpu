#!/bin/bash
# entrypoint.sh

if [ -z "$MODEL_PATH" ] || [ -z "$HF_PATH" ]; then
    echo "Error: Required environment variables are not set."
    echo "MODEL_PATH and HF_PATH must be provided."
    exit 1
fi

exec python -m llama_cpp.server
