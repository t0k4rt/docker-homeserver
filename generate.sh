#!/bin/bash

LETSENCRYPT_MAIL=""

POSTGRES_ADMIN_PASSWORD=""

PGID=1000
PUID=1000

LOCAL_HOSTNAME="tokserver.local"
DOMAIN="toktok.fr"

NEXTCLOUD_PASSWORD=""
NEXTCLOUD_DB="nextcloud"
NEXTCLOUD_DB_USER="nextcloud"
NEXTCLOUD_DATA=""
NEXTCLOUD_CONFIG=""
NEXTCLOUD_VHOST="nextcloud.toktok.fr"

COCKPIT_VHOST="cockpit.toktok.fr"

TRANSMISSION_VHOST="transmission.toktok.fr"
TRANSMISSION_DATA=""
TRANSMISSION_CONFIG=""

RADARR_VHOST="radarr.toktok.fr"

TRAEFIK_CONF_DIR=""
TRAEFIK_LETSENCRYPT_DIR=""


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


SUBJECT="Traefik config dir"
while true; do
    read -p "$SUBJECT: " TRAEFIK_CONF_DIR
    if [ -z "$TRAEFIK_CONF_DIR" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        TRAEFIK_LETSENCRYPT_DIR="$TRAEFIK_CONF_DIR"
        break
    fi
done


SUBJECT="Postgres admin password"
while true; do
    read -p "$SUBJECT: " POSTGRES_ADMIN_PASSWORD
    if [ -z "$POSTGRES_ADMIN_PASSWORD" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done



SUBJECT="Nextcloud db password"
while true; do
    read -p "$SUBJECT: " NEXTCLOUD_PASSWORD
    if [ -z "$NEXTCLOUD_PASSWORD" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done

SUBJECT="Nextcloud DB"
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

SUBJECT="Nextcloud User"
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


SUBJECT="Nextcloud vhost"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $NEXTCLOUD_VHOST"
        break
    else
        NEXTCLOUD_VHOST="$value"
        break
    fi
done


SUBJECT="Nextcloud data dir"
while true; do
    read -p "$SUBJECT: " NEXTCLOUD_DATA
    if [ -z "$NEXTCLOUD_DATA" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done

SUBJECT="Nextcloud config dir"
while true; do
    read -p "$SUBJECT: " NEXTCLOUD_CONFIG
    if [ -z "$NEXTCLOUD_CONFIG" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done


SUBJECT="Cockpit vhost"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $COCKPIT_VHOST"
        break
    else
        COCKPIT_VHOST="$value"
        break
    fi
done


SUBJECT="Transmission vhost"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $TRANSMISSION_VHOST"
        break
    else
        TRANSMISSION_VHOST="$value"
        break
    fi
done


SUBJECT="Transmission data dir"
while true; do
    read -p "$SUBJECT: " TRANSMISSION_DATA
    if [ -z "$TRANSMISSION_DATA" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done


SUBJECT="Transmission config dir"
while true; do
    read -p "$SUBJECT: " TRANSMISSION_CONFIG
    if [ -z "$TRANSMISSION_CONFIG" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done


SUBJECT="Radarr vhost"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $RADARR_VHOST"
        break
    else
        RADARR_VHOST="$value"
        break
    fi
done

# SUBJECT="Jackett vhost"
# while true; do
#     read -p "$SUBJECT: " value
#     if [ -z "$value" ]; then
#         echo "Using default $SUBJECT: $JACKETT_VHOST"
#         break
#     else
#         JACKETT_VHOST="$value"
#         break
#     fi
# done


VHOST_LIST="\"${TRANSMISSION_VHOST}\",\"${NEXTCLOUD_VHOST}\",\"${COCKPIT_VHOST}\",\"${RADARR_VHOST}\""
TRAEFIK_CONF_FILE="${TRAEFIK_CONF_DIR}/traefik.toml"
TRAEFIK_LETSENCRYPT_FILE="${TRAEFIK_CONF_DIR}/acme.json"


# DB
cat db.tpl.env | sed -e "s|{{POSTGRES_ADMIN_PASSWORD}}|$POSTGRES_ADMIN_PASSWORD|g;" > db.env
cat db/init.tpl.sql | sed -e "s|{{NEXTCLOUD_PASSWORD}}|$NEXTCLOUD_PASSWORD|g;" > db/init.sql

#Nextcloud
cat nextcloud.tpl.env | sed -e "s|{{PGID}}|$PGID|g;s|{{PUID}}|$PUID|g;s|{{NEXTCLOUD_PASSWORD}}|$NEXTCLOUD_PASSWORD|g;s|{{NEXTCLOUD_DB}}|$NEXTCLOUD_DB|g;s|{{NEXTCLOUD_DB_USER}}|$NEXTCLOUD_DB_USER|g" > nextcloud.env

# Transmission
cat transmission.tpl.env | sed -e "s|{{PGID}}|$PGID|g;s|{{PUID}}|$PUID|g;" > transmission.env

# Radarr
cat radarr.tpl.env | sed -e "s|{{PGID}}|$PGID|g;s|{{PUID}}|$PUID|g;" > radarr.env

# Jackett
cat jackett.tpl.env | sed -e "s|{{PGID}}|$PGID|g;s|{{PUID}}|$PUID|g;" > jackett.env

# Docker compose 
cat docker-compose.tpl.yml | sed -e "s|{{TRAEFIK_CONF_FILE}}|$TRAEFIK_CONF_FILE|g;s|{{TRAEFIK_LETSENCRYPT_FILE}}|$TRAEFIK_LETSENCRYPT_FILE|g;s|{{NEXTCLOUD_VHOST}}|$NEXTCLOUD_VHOST|g;s|{{NEXTCLOUD_DATA}}|$NEXTCLOUD_DATA|g;s|{{NEXTCLOUD_CONFIG}}|$NEXTCLOUD_CONFIG|g;s|{{TRANSMISSION_VHOST}}|$TRANSMISSION_VHOST|g;s|{{TRANSMISSION_DATA}}|$TRANSMISSION_DATA|g;s|{{TRANSMISSION_CONFIG}}|$TRANSMISSION_CONFIG|g" > docker-compose.yml

# Traefik
cat traefik/traefik.tpl.toml | sed -e "s|{{LETSENCRYPT_MAIL}}|$LETSENCRYPT_MAIL|g;s|{{COCKPIT_VHOST}}|$COCKPIT_VHOST|g;s|{{DOMAIN}}|$DOMAIN|g;s|{{VHOST_LIST}}|$VHOST_LIST|g" traefik/traefik.tpl.toml > traefik/traefik.tpl.toml

echo $TRAEFIK_CONF_FILE
if [ -d $TRAEFIK_CONF_FILE ]; then 
    sudo rm $TRAEFIK_CONF_FILE
fi
if [ -e $TRAEFIK_CONF_FILE ]; then 
    sudo touch $TRAEFIK_CONF_FILE
    sudo mv traefik/traefik.toml $TRAEFIK_CONF_FILE
fi

echo $TRAEFIK_LETSENCRYPT_FILE
if [ -d $TRAEFIK_LETSENCRYPT_FILE ]; then 
    sudo rm $TRAEFIK_LETSENCRYPT_FILE
fi
if [ -e $TRAEFIK_LETSENCRYPT_FILE ]; then 
    sudo touch $TRAEFIK_LETSENCRYPT_FILE
fi
sudo chmod 600 $TRAEFIK_LETSENCRYPT_FILE