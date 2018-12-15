#!/bin/bash

LETSENCRYPT_MAIL=""

POSTGRES_ADMIN_PASSWORD=""

PGID=33
PUID=33

LOCAL_HOSTNAME="tokserver.local"
DOMAIN="toktok.fr"

NEXTCLOUD_PASSWORD=""
NEXTCLOUD_DB="nextcloud"
NEXTCLOUD_DB_USER="nextcloud"
NEXTCLOUD_DATA=""
NEXTCLOUD_FILER_USER="grosfichier"

NEXTCLOUD_HOST="nextcloud.toktok.fr"
COCKPIT_HOST="cockpit.toktok.fr"
TRANSMISSION_HOST="transmission.toktok.fr"
RADARR_HOST="radarr.toktok.fr"
JACKETT_HOST="jackett.local"

CONFIG_DIR=""
TORRENT_WATCH_DIR=""
MOVIE_DOWNLOAD_DIR=""


#### READ VARIABLES
SUBJECT="Let's encrypt email"
while true; do
    read -p "$SUBJECT: " LETSENCRYPT_MAIL
    if [ -z "$LETSENCRYPT_MAIL" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""

SUBJECT="Config dir"
while true; do
    read -p "$SUBJECT: " CONFIG_DIR
    if [ -z "$CONFIG_DIR" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""

SUBJECT="Movie download dir"
while true; do
    read -p "$SUBJECT: " MOVIE_DOWNLOAD_DIR
    if [ -z "$MOVIE_DOWNLOAD_DIR" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""

SUBJECT="Postgres admin password"
while true; do
    read -p "$SUBJECT: " POSTGRES_ADMIN_PASSWORD
    if [ -z "$POSTGRES_ADMIN_PASSWORD" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""

SUBJECT="Nextcloud db password"
while true; do
    read -p "$SUBJECT: " NEXTCLOUD_PASSWORD
    if [ -z "$NEXTCLOUD_PASSWORD" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""

SUBJECT="Nextcloud DB name (Default ${NEXTCLOUD_DB})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $NEXTCLOUD_DB"
        break
    else
        NEXTCLOUD_DB="$value"
        break
    fi
done
echo ""

SUBJECT="Nextcloud User (Default ${NEXTCLOUD_DB_USER})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $NEXTCLOUD_DB_USER"
        break
    else
        NEXTCLOUD_DB_USER="$value"
        break
    fi
done
echo ""

SUBJECT="Nextcloud host (default ${NEXTCLOUD_HOST})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $NEXTCLOUD_HOST"
        break
    else
        NEXTCLOUD_HOST="$value"
        break
    fi
done
echo ""

SUBJECT="Nextcloud data dir"
while true; do
    read -p "$SUBJECT: " NEXTCLOUD_DATA
    if [ -z "$NEXTCLOUD_DATA" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""

SUBJECT="Cockpit host (default ${COCKPIT_HOST})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $COCKPIT_HOST"
        break
    else
        COCKPIT_HOST="$value"
        break
    fi
done
echo ""

SUBJECT="Transmission host (default ${TRANSMISSION_HOST})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $TRANSMISSION_HOST"
        break
    else
        TRANSMISSION_HOST="$value"
        break
    fi
done
echo ""

SUBJECT="Radarr host (default ${RADARR_HOST})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $RADARR_HOST"
        break
    else
        RADARR_HOST="$value"
        break
    fi
done
echo ""

DATA_DIR=""
SUBJECT="Data dir"
while true; do
    read -p "$SUBJECT: "  DATA_DIR
    if [ -z "$DATA_DIR" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""


RADARR_MOVIES="${NEXTCLOUD_DATA}/${NEXTCLOUD_FILER_USER}/files/Films"
BITTORRENT_DOWNLOAD_DIR="${NEXTCLOUD_DATA}/${NEXTCLOUD_FILER_USER}/files/Torrent"
#RADARR_DOWNLOADS="${DATA_DIR}/radarr_downloads"

# Global env
rm ./env/global.env || true
echo PGID=${PGID} >> ./env/global.env
echo PUID=${PUID} >> ./env/global.env
echo CONFIG_DIR=${CONFIG_DIR} >> ./env/global.env
echo BITTORRENT_DOWNLOAD_DIR=${BITTORRENT_DOWNLOAD_DIR} >> ./env/global.env

# DB
cat db/init.tpl.sql | sed -e "s|{{NEXTCLOUD_PASSWORD}}|$NEXTCLOUD_PASSWORD|g;" > db/init.sql
rm ./env/db.env || true
echo POSTGRES_ADMIN_PASSWORD=${POSTGRES_ADMIN_PASSWORD} >> ./env/db.env

#Nextcloud
rm ./env/nextcloud.env || true
echo NEXTCLOUD_PASSWORD=${NEXTCLOUD_PASSWORD} >> ./env/nextcloud.env
echo NEXTCLOUD_DB=${NEXTCLOUD_DB} >> ./env/nextcloud.env
echo NEXTCLOUD_DB_USER=${NEXTCLOUD_DB_USER} >> ./env/nextcloud.env
echo NEXTCLOUD_DATA=${NEXTCLOUD_DATA} >> ./env/nextcloud.env

# Radarr
rm ./env/radarr.env || true
echo RADARR_TZ=Europe/Paris  >> ./env/radarr.env
echo RADARR_MOVIES=${RADARR_MOVIES} >> ./env/radarr.env
#echo RADARR_DOWNLOADS=${RADARR_DOWNLOADS} >> ./env/radarr.env

# Jackett
# Transmission

#  Treafik
HOST_LIST="\"${TRANSMISSION_HOST}\",\"${NEXTCLOUD_HOST}\",\"${COCKPIT_HOST}\",\"${RADARR_HOST}\""
TRAEFIK_CONF_DIR="${CONFIG_DIR}/traefik"
TRAEFIK_CONF_FILE="${TRAEFIK_CONF_DIR}/traefik.toml"
TRAEFIK_LETSENCRYPT_FILE="${TRAEFIK_CONF_DIR}/acme.json"

echo $TRAEFIK_CONF_FILE
sudo mkdir -p $TRAEFIK_CONF_DIR
if [ -d $TRAEFIK_CONF_FILE ]; then 
    sudo rm $TRAEFIK_CONF_FILE
fi
if [ ! -e $TRAEFIK_CONF_FILE ]; then 
    sudo touch $TRAEFIK_CONF_FILE
    sudo mv traefik/traefik.toml $TRAEFIK_CONF_FILE
fi

echo $TRAEFIK_LETSENCRYPT_FILE
if [ -d $TRAEFIK_LETSENCRYPT_FILE ]; then 
    sudo rm $TRAEFIK_LETSENCRYPT_FILE
fi
if [ ! -e $TRAEFIK_LETSENCRYPT_FILE ]; then 
    sudo touch $TRAEFIK_LETSENCRYPT_FILE
fi
sudo chmod 600 $TRAEFIK_LETSENCRYPT_FILE

rm ./env/traefik.env || true
echo TRAEFIK_CONF_FILE=${TRAEFIK_CONF_FILE} >> ./env/traefik.env
echo TRAEFIK_LETSENCRYPT_FILE=${TRAEFIK_LETSENCRYPT_FILE} >> ./env/traefik.env

# Docker compose 
cat docker-compose.tpl.yml | sed -e "s|{{NEXTCLOUD_HOST}}|$NEXTCLOUD_HOST|g;s|{{TRANSMISSION_HOST}}|$TRANSMISSION_HOST|g;s|{{JACKETT_HOST}}|$JACKETT_HOST|g;s|{{RADARR_HOST}}|$RADARR_HOST|g;" > docker-compose.yml

# Traefik
cat traefik/traefik.tpl.toml | sed -e "s|{{LETSENCRYPT_MAIL}}|$LETSENCRYPT_MAIL|g;s|{{COCKPIT_HOST}}|$COCKPIT_HOST|g;s|{{DOMAIN}}|$DOMAIN|g;s|{{HOST_LIST}}|$HOST_LIST|g" > traefik/traefik.toml
