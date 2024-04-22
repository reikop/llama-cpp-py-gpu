ARG CUDA_IMAGE="12.1.1-devel-ubuntu22.04"
FROM --platform=amd64 nvidia/cuda:${CUDA_IMAGE}

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    python3 python3-pip gcc wget \
    ocl-icd-opencl-dev opencl-headers clinfo \
    libclblast-dev libopenblas-dev \
    && mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
# 필요한 파일 복사
COPY . /app

# 작업 디렉토리 설정
WORKDIR /app
RUN python3 -m pip install --upgrade pip pytest cmake scikit-build setuptools fastapi uvicorn sse-starlette pydantic-settings starlette-context transformers
RUN CMAKE_ARGS="-DLLAMA_CUBLAS=on" pip install llama-cpp-python

CMD python3 -m llama_cpp.server