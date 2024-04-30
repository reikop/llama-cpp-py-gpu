import re
import requests
from packaging import version
import logging

def create_new_dockerfile():
    with open('_Dockerfile', 'r') as file:
        dockerfile_contents = file.read()

    current_version_match = re.search(r'llama-cpp-python==([\d\.]+)', dockerfile_contents)
    if not current_version_match:
        raise ValueError("현재 버전을 Dockerfile에서 찾을 수 없습니다.")

    current_version = current_version_match.group(1)
    response = requests.get('https://pypi.org/pypi/llama-cpp-python/json')
    latest_version = response.json()['info']['version']

    new_dockerfile_contents = re.sub(r'llama-cpp-python==[\d\.]+', f'llama-cpp-python=={latest_version}', dockerfile_contents)
    with open('Dockerfile', 'w') as file:
        file.write(new_dockerfile_contents)
    return latest_version

if __name__ == "__main__":
    latest_version = create_new_dockerfile()
    print(latest_version)
