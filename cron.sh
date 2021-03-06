#!/bin/bash
set -e

BASE_DIR="$(dirname "$0")"

# get real full path
realpath () {
  local path=$1
  cd $path && pwd
}

FULLPATH=$(realpath "${BASE_DIR}")

# load env vars
export $(cat $FULLPATH/env/*.env | xargs)

# trigger file scan
/usr/local/bin/docker-compose -f $FULLPATH/docker-compose.yml exec -T -u $GID nextcloud php /config/www/nextcloud/occ files:scan $NEXTCLOUD_FILER_USER && echo "scan ok"
