#!/bin/bash

# 파이썬 가상 환경 설정
python3 -m venv venv

# 가상 환경 활성화
source venv/bin/activate

# 필요한 패키지 설치
pip install requests packaging
VERSION=$(python make_dockerfile.py)
echo $VERSION
docker build -t reikop/llama-cpp-py-gpu:$VERSION .
docker push reikop/llama-cpp-py-gpu:$VERSION
deactivate
