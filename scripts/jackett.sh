# Jackett

JACKETT_DEFAULT_HOST="jackett.$DOMAIN"

SUBJECT="Jackett host (default ${JACKETT_DEFAULT_HOST})"
JACKETT_HOST=$(ask_value_with_default "$SUBJECT" "$JACKETT_DEFAULT_HOST" "$JACKETT_HOST")


rm "$BASE_DIR"/env/jackett.env 2> /dev/null
JACKETT_CONFIG_DIR="$CONFIG_DIR/jackett"

{
    echo JACKETT_HOST="${JACKETT_HOST}"
    echo JACKETT_CONFIG_DIR="${JACKETT_CONFIG_DIR}"
} >> "$BASE_DIR"/env/jackett.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$JACKETT_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$JACKETT_HOST\"" 
fi