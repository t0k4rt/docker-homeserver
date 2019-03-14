# Nextcloud
NEXTCLOUD_HOST="nextcloud.$DOMAIN"
NEXTCLOUD_PASSWORD=""
NEXTCLOUD_DB="nextcloud"
NEXTCLOUD_DB_USER="nextcloud"
NEXTCLOUD_DATA=""
NEXTCLOUD_FILER_USER="grosfichier"


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


rm $BASE_DIR/env/nextcloud.env 2> /dev/null
NEXTCLOUD_CONFIG_DIR="$CONFIG_DIR/nextcloud"

echo NEXTCLOUD_PASSWORD=${NEXTCLOUD_PASSWORD} >> $BASE_DIR/env/nextcloud.env
echo NEXTCLOUD_DB=${NEXTCLOUD_DB} >> $BASE_DIR/env/nextcloud.env
echo NEXTCLOUD_DB_USER=${NEXTCLOUD_DB_USER} >> $BASE_DIR/env/nextcloud.env
echo NEXTCLOUD_DATA=${NEXTCLOUD_DATA} >> $BASE_DIR/env/nextcloud.env
echo NEXTCLOUD_HOST=${NEXTCLOUD_HOST} >> $BASE_DIR/env/nextcloud.env
echo NEXTCLOUD_FILER_USER=${NEXTCLOUD_FILER_USER} >> $BASE_DIR/env/nextcloud.env
echo NEXTCLOUD_CONFIG_DIR=${NEXTCLOUD_CONFIG_DIR} >> $BASE_DIR/env/nextcloud.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$NEXTCLOUD_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$NEXTCLOUD_HOST\"" 
fi