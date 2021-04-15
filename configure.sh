#!/bin/bash

BASE_DIR="$(dirname "$0")"

# shellcheck source=functions.sh
source "$BASE_DIR/functions.sh"

# read already set parameters
export $(cat ./env/*.env | xargs)

PGID=1111
PUID=1111

if [ `cat /etc/passwd|grep $PGID|wc -l` == "0" ] && [ `uname` != "Darwin" ]; then
    groupadd -g $PGID homeserver
    useradd -M -u $PUID -g $PGID homeserver
fi

LOCAL_HOSTNAME="elsa.lan"
DOMAIN="toktok.fr"
HOST_LIST=""


#### READ VARIABLES
SUBJECT="Config dir"
CONFIG_DIR=$(ask_value "$SUBJECT" "$CONFIG_DIR")


# Global env
rm $BASE_DIR/env/global.env 2> /dev/null
echo TIMEZONE=Europe/Paris  >> $BASE_DIR/env/global.env
echo PGID=${PGID} >> $BASE_DIR/env/global.env
echo PUID=${PUID} >> $BASE_DIR/env/global.env
echo CONFIG_DIR=${CONFIG_DIR} >> $BASE_DIR/env/global.env

source $BASE_DIR/scripts/portainer.sh
source $BASE_DIR/scripts/nextcloud.sh
source $BASE_DIR/scripts/db.sh
source $BASE_DIR/scripts/transmission.sh
source $BASE_DIR/scripts/radarr.sh
source $BASE_DIR/scripts/sonarr.sh
source $BASE_DIR/scripts/jackett.sh
source $BASE_DIR/scripts/jellyfin.sh
source $BASE_DIR/scripts/shaarli.sh
source $BASE_DIR/scripts/samba.sh
source $BASE_DIR/scripts/influxdb.sh
source $BASE_DIR/scripts/grafana.sh
source $BASE_DIR/scripts/loki.sh
source $BASE_DIR/scripts/homeassistant.sh
source $BASE_DIR/scripts/shairport-sync.sh
source $BASE_DIR/scripts/snapcast.sh
source $BASE_DIR/scripts/mylar.sh
source $BASE_DIR/scripts/traefik.sh

BITTORRENT_DOWNLOAD_DIR="${NEXTCLOUD_DATA}/${NEXTCLOUD_FILER_USER}/files/Torrents"
echo BITTORRENT_DOWNLOAD_DIR=${BITTORRENT_DOWNLOAD_DIR} >> $BASE_DIR/env/global.env

echo "Update rights on folders $NEXTCLOUD_DATA, $CONFIG_DIR"
chown -R $PUID:$PGID $NEXTCLOUD_DATA
chown -R $PUID:$PGID $CONFIG_DIR

# Docker compose
cp docker-compose.tpl.yml docker-compose.yml