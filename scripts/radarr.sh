# Radarr
if [ -z "$NEXTCLOUD_FILER_USER" ]; then
    echo "DB depends on nextcloud package, source nextcloud first"
    break
fi

RADARR_HOST="radarr.$DOMAIN"

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

rm $BASE_DIR/env/radarr.env || true
RADARR_MEDIAS="${NEXTCLOUD_DATA}/${NEXTCLOUD_FILER_USER}/files/Films"
RADARR_CONFIG_DIR="$CONFIG/radarr"

echo RADARR_HOST=${RADARR_HOST} >> $BASE_DIR/env/radarr.env
echo RADARR_MEDIAS=${RADARR_MEDIAS} >> $BASE_DIR/env/radarr.env
echo RADARR_CONFIG_DIR=${RADARR_CONFIG_DIR} >> $BASE_DIR/env/radarr.env

if [ -z HOST_LIST ]; then 
    HOST_LIST="\"$RADARR_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$RADARR_HOST\"" 
fi