# Jellyfin

JELLYFIN_DEFAULT_HOST="jellyfin.$DOMAIN"
SUBJECT="Jellyfin host (default ${JELLYFIN_DEFAULT_HOST})"
JELLYFIN_HOST=$(ask_value_with_default "$SUBJECT" "$JELLYFIN_DEFAULT_HOST" "$JELLYFIN_HOST")

rm "$BASE_DIR"/env/jellyfin.env 2> /dev/null
JELLYFIN_CONFIG_DIR="$CONFIG_DIR/jellyfin"

{
    echo JELLYFIN_HOST="${JELLYFIN_HOST}"
    echo JELLYFIN_CONFIG_DIR="${JELLYFIN_CONFIG_DIR}"
} >> "$BASE_DIR"/env/jellyfin.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$JELLYFIN_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$JELLYFIN_HOST\"" 
fi