# Sonarr
if [ -z "$NEXTCLOUD_FILER_USER" ]; then
    echo "DB depends on nextcloud package, source nextcloud first"
    break
fi

SONARR_HOST="sonarr.$DOMAIN"

SUBJECT="Sonarr host (default ${SONARR_HOST})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $SONARR_HOST"
        break
    else
        SONARR_HOST="$value"
        break
    fi
done
echo ""

rm $BASE_DIR/env/sonarr.env || true
SONARR_MEDIAS="${NEXTCLOUD_DATA}/${NEXTCLOUD_FILER_USER}/files/Tv"
SONARR_CONFIG_DIR="$CONFIG/sonarr"

echo SONARR_HOST=${SONARR_HOST} >> $BASE_DIR/env/sonarr.env
echo SONARR_MEDIAS=${SONARR_MEDIAS} >> $BASE_DIR/env/sonarr.env
echo SONARR_CONFIG_DIR=${SONARR_CONFIG_DIR} >> $BASE_DIR/env/sonarr.env

if [ -z HOST_LIST ]; then 
    HOST_LIST="\"$SONARR_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$SONARR_HOST\"" 
fi