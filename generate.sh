#!/bin/bash


LETSENCRYPT_MAIL=""

NEXTCLOUD_PASSWORD=""
NEXTCLOUD_DB="nextcloud"
NEXTCLOUD_DB_USER="nextcloud"
NEXTCLOUD_DATA=""
NEXTCLOUD_VHOST="nextcloud.toktok.fr"
NEXTCLOUD_LETSENCRYPT_HOST="nextcloud.toktok.fr"

COCKPIT_VHOST="cockpit.toktok.fr"
COCKPIT_LETSENCRYPT_HOST="cockpit.toktok.fr"

TRANSMISSION_VHOST="transmission.toktok.fr"
TRANSMISSION_LETSENCRYPT_HOST="transmission.toktok.fr"
TRANSMISSION_VIRTUAL_PORT="9091"
TRANSMISSION_DATA=""
TRANSMISSION_CONFIG=""

SUBJECT="Let's encrypt email"
while true; do
    read -p "$SUBJECT: " LETSENCRYPT_MAIL
    if [ -z "$LETSENCRYPT_MAIL" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done

SUBJECT="Nextcloud password"
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


SUBJECT="Nextcloud vhost / letsencrypt host"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $NEXTCLOUD_VHOST / $NEXTCLOUD_LETSENCRYPT_HOST"
        break
    else
        NEXTCLOUD_VHOST="$value"
        NEXTCLOUD_LETSENCRYPT_HOST="$value"
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


SUBJECT="Cockpit vhost / letsencrypt host"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $COCKPIT_VHOST / $COCKPIT_LETSENCRYPT_HOST"
        break
    else
        COCKPIT_VHOST="$value"
        COCKPIT_LETSENCRYPT_HOST="$value"
        break
    fi
done


SUBJECT="Transmission vhost / letsencrypt host"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $TRANSMISSION_VHOST / $TRANSMISSION_LETSENCRYPT_HOST"
        break
    else
        TRANSMISSION_VHOST="$value"
        TRANSMISSION_LETSENCRYPT_HOST="$value"
        break
    fi
done


SUBJECT="Transmission virtual port"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $TRANSMISSION_VIRTUAL_PORT"
        break
    else
        TRANSMISSION_VIRTUAL_PORT="$value"
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

cat db.tpl.env | sed -e "s|{{NEXTCLOUD_PASSWORD}}|$NEXTCLOUD_PASSWORD|g;s|{{NEXTCLOUD_DB}}|$NEXTCLOUD_DB|g;s|{{NEXTCLOUD_DB_USER}}|$NEXTCLOUD_DB_USER|g" > db.env
cat web_cockpit.tpl.env | sed -e "s|{{LETSENCRYPT_MAIL}}|$LETSENCRYPT_MAIL|g;s|{{COCKPIT_VHOST}}|$COCKPIT_VHOST|g;s|{{COCKPIT_LETSENCRYPT_HOST}}|$COCKPIT_LETSENCRYPT_HOST|g" > web_cockpit.env
cat web_nextcloud.tpl.env | sed -e "s|{{LETSENCRYPT_MAIL}}|$LETSENCRYPT_MAIL|g;s|{{NEXTCLOUD_VHOST}}|$NEXTCLOUD_VHOST|g;s|{{NEXTCLOUD_LETSENCRYPT_HOST}}|$NEXTCLOUD_LETSENCRYPT_HOST|g" > web_nextcloud.env
cat transmission.tpl.env | sed -e "s|{{LETSENCRYPT_MAIL}}|$LETSENCRYPT_MAIL|g;s|{{TRANSMISSION_VHOST}}|$TRANSMISSION_VHOST|g;s|{{TRANSMISSION_LETSENCRYPT_HOST}}|$TRANSMISSION_LETSENCRYPT_HOST|g;s|{{TRANSMISSION_VIRTUAL_PORT}}|$TRANSMISSION_VIRTUAL_PORT|g" > transmission.env
cat docker-compose.tpl.yml | sed -e "s|{{NEXTCLOUD_DATA}}|$NEXTCLOUD_DATA|g;s|{{TRANSMISSION_DATA}}|$TRANSMISSION_DATA|g;s|{{TRANSMISSION_CONFIG}}|$TRANSMISSION_CONFIG|g" > docker-compose.yml