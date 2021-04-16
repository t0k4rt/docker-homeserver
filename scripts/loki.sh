# Loki
rm "$BASE_DIR"/env/loki.env 2> /dev/null

LOKI_DEFAULT_HOST="loki.$DOMAIN"

SUBJECT="Loki host (default ${LOKI_DEFAULT_HOST})"
LOKI_HOST=$(ask_value_with_default "$SUBJECT" "$LOKI_DEFAULT_HOST" "$LOKI_HOST")

LOKI_CONFIG_DIR="$CONFIG_DIR/loki/config"

{
    echo LOKI_HOST="${LOKI_HOST}" 
    echo LOKI_CONFIG_DIR="${LOKI_CONFIG_DIR}"
} >> "$BASE_DIR"/env/loki.env


# if [ -z "$HOST_LIST" ]; then 
#     HOST_LIST="\"$LOKI_HOST\"" 
# else
#     HOST_LIST="$HOST_LIST,\"$LOKI_HOST\"" 
# fi
