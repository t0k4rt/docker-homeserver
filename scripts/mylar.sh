# Mylar
if [ -z "$NEXTCLOUD_FILER_USER" ]; then
    echo "DB depends on nextcloud package, source nextcloud first"
    exit 1
fi

MYLAR_DEFAULT_HOST="mylar.$DOMAIN"

SUBJECT="Mylar host (default ${MYLAR_DEFAULT_HOST})"
MYLAR_HOST=$(ask_value_with_default "$SUBJECT" "$MYLAR_DEFAULT_HOST" "$MYLAR_HOST")


rm "$BASE_DIR"/env/mylar.env 2> /dev/null
MYLAR_MEDIAS="${NEXTCLOUD_DATA}/${NEXTCLOUD_FILER_USER}/files/Comics"
MYLAR_CONFIG_DIR="$CONFIG_DIR/mylar"

{
    echo MYLAR_HOST=${MYLAR_HOST}
    echo MYLAR_MEDIAS=${MYLAR_MEDIAS}
    echo MYLAR_CONFIG_DIR=${MYLAR_CONFIG_DIR}
} >> "$BASE_DIR"/env/mylar.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$MYLAR_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$MYLAR_HOST\"" 
fi