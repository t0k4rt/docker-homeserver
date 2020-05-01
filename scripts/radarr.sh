# Radarr
if [ -z "$NEXTCLOUD_FILER_USER" ]; then
    echo "DB depends on nextcloud package, source nextcloud first"
    exit 1
fi

RADARR_DEFAULT_HOST="radarr.$DOMAIN"

SUBJECT="Radarr host (default ${RADARR_DEFAULT_HOST})"
RADARR_HOST=$(ask_value_with_default "$SUBJECT" "$RADARR_DEFAULT_HOST" "$RADARR_HOST")

rm "$BASE_DIR"/env/radarr.env 2> /dev/null
RADARR_MEDIAS="${NEXTCLOUD_DATA}/${NEXTCLOUD_FILER_USER}/files/Films"
RADARR_CONFIG_DIR="$CONFIG_DIR/radarr"

{
    echo RADARR_HOST=${RADARR_HOST}
    echo RADARR_MEDIAS=${RADARR_MEDIAS}
    echo RADARR_CONFIG_DIR=${RADARR_CONFIG_DIR}
} >> "$BASE_DIR"/env/radarr.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$RADARR_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$RADARR_HOST\"" 
fi