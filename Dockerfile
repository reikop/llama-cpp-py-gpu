ARG CUDA_IMAGE="12.1.1-devel-ubuntu22.04"
FROM --platform=amd64 nvidia/cuda:${CUDA_IMAGE}

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    python3 python3-pip gcc wget \
    ocl-icd-opencl-dev opencl-headers clinfo \
    libclblast-dev libopenblas-dev \
    && mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

COPY . .
WORKDIR .
VOLUME /app


# setting build related env vars
ENV CUDA_DOCKER_ARCH=all
ENV LLAMA_CUBLAS=1
ENV HOST=0.0.0.0
ENV PORT=8000


RUN python3 -m pip install --upgrade pip pytest cmake scikit-build setuptools fastapi uvicorn sse-starlette pydantic-settings starlette-context transformers
RUN CMAKE_ARGS="-DLLAMA_CUBLAS=on" pip install llama-cpp-python

EXPOSE 8000
CMD python3 -m llama_cpp.server