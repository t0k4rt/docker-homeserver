#!/bin/bash

TODAY=$(date +"%m-%d-%Y")
docker build -t test-librespot --build-arg BUILD_DATE="$TODAY" -f docker_images/librespot/Dockerfile . 