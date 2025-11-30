#!/bin/bash

docker buildx build --platform linux/arm64,linux/amd64 -t hackinglab/debian-base-hl:latest -f Dockerfile . --push
docker buildx build --platform linux/arm64,linux/amd64 -t hackinglab/debian-base-hl:$1 -f Dockerfile . --push
docker buildx build --platform linux/arm64,linux/amd64 -t hackinglab/debian-base-hl:$1.0 -f Dockerfile . --push
