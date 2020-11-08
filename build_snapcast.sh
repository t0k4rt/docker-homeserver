#!/bin/bash

TODAY=$(date +"%m-%d-%Y")
docker build -t test-snapcast --build-arg BUILD_DATE="$TODAY" -f docker_images/snapcast-server/Dockerfile . 
docker build -t test-snapcast-client --build-arg BUILD_DATE="$TODAY" -f docker_images/snapcast-client/Dockerfile . 