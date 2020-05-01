# Sonarr
if [ -z "$NEXTCLOUD_FILER_USER" ]; then
    echo "DB depends on nextcloud package, source nextcloud first"
    exit 1
fi

SONARR_DEFAULT_HOST="sonarr.$DOMAIN"

SUBJECT="Sonarr host (default ${SONARR_DEFAULT_HOST})"
SONARR_HOST=$(ask_value_with_default "$SUBJECT" "$SONARR_DEFAULT_HOST" "$SONARR_HOST")


rm "$BASE_DIR"/env/sonarr.env 2> /dev/null
SONARR_MEDIAS="${NEXTCLOUD_DATA}/${NEXTCLOUD_FILER_USER}/files/Tv"
SONARR_CONFIG_DIR="$CONFIG_DIR/sonarr"

{
    echo SONARR_HOST=${SONARR_HOST}
    echo SONARR_MEDIAS=${SONARR_MEDIAS}
    echo SONARR_CONFIG_DIR=${SONARR_CONFIG_DIR}
} >> "$BASE_DIR"/env/sonarr.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$SONARR_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$SONARR_HOST\"" 
fi