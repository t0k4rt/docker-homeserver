# Shaarli
rm "$BASE_DIR"/env/shaarli.env 2> /dev/null

SHAARLI_DEFAULT_HOST="shaarli.$DOMAIN"

SUBJECT="Shaarli host (default ${SHAARLI_DEFAULT_HOST})"
SHAARLI_HOST=$(ask_value_with_default "$SUBJECT" "$SHAARLI_DEFAULT_HOST" "$SHAARLI_HOST")

SHAARLI_CONFIG_DIR="$CONFIG_DIR/shaarli/config"

{
    echo SHAARLI_HOST="${SHAARLI_HOST}" 
    echo SHAARLI_CONFIG_DIR="${SHAARLI_CONFIG_DIR}"
} >> "$BASE_DIR"/env/shaarli.env


if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$SHAARLI_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$SHAARLI_HOST\"" 
fi
