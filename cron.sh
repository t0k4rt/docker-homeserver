#!/bin/bash

set -e

BASE_DIR="$(dirname "$0")"
CURRENT_DIR="$(pwd)"

# get real full path
realpath () {
  local path=$1
  cd $path && pwd
}

FULLPATH=$(realpath "${CURRENT_DIR}/${BASE_DIR}")

# load env vars
export $(cat $FULLPATH/env/*.env | xargs)

# trigger file scan
docker-compose exec --user www-data nextcloud php occ files:scan $NEXTCLOUD_FILER_USER