#!/bin/bash

export $(cat ./env/*.env | xargs)
docker-compose up