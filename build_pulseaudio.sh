#!/bin/bash

TODAY=$(date +"%m-%d-%Y")
docker build -t test-pulseaudio --build-arg BUILD_DATE="$TODAY" -f docker_images/pulseaudio/Dockerfile . 