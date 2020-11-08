# Snapcast
if [ -z "$NEXTCLOUD_FILER_USER" ]; then
    echo "DB depends on nextcloud package, source nextcloud first"
    exit 1
fi

SNAPCAST_DEFAULT_HOST="snapcast.$DOMAIN"

SUBJECT="Snapcast host (default ${SNAPCAST_DEFAULT_HOST})"
SNAPCAST_HOST=$(ask_value_with_default "$SUBJECT" "$SNAPCAST_DEFAULT_HOST" "$SNAPCAST_HOST")

rm "$BASE_DIR"/env/snapcast.env 2> /dev/null
SNAPCAST_CONFIG_DIR="$CONFIG_DIR/snapcast"

{
    echo SNAPCAST_HOST=${SNAPCAST_HOST}
    echo SNAPCAST_CONFIG_DIR=${SNAPCAST_CONFIG_DIR}

} >> "$BASE_DIR"/env/snapcast.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$SNAPCAST_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$SNAPCAST_HOST\"" 
fi