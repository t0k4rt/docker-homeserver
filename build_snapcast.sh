#!/bin/bash

TODAY=$(date +"%m-%d-%Y")
docker build -t test-snapcast --build-arg VERSION="0.22.0" --build-arg BUILD_DATE="$TODAY" -f docker_images/snapcast-server/Dockerfile . 