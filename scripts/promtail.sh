# PROMTAIL
rm "$BASE_DIR"/env/loki.env 2> /dev/null

PROMTAIL_DEFAULT_HOST="promtail.$DOMAIN"

SUBJECT="Loki host (default ${PROMTAIL_DEFAULT_HOST})"
PROMTAIL_HOST=$(ask_value_with_default "$SUBJECT" "$PROMTAIL_DEFAULT_HOST" "$PROMTAIL_HOST")

PROMTAIL_CONFIG_DIR="$CONFIG_DIR/promtail/config"

{
    echo PROMTAIL_HOST="${PROMTAIL_HOST}" 
    echo PROMTAIL_CONFIG_DIR="${PROMTAIL_CONFIG_DIR}"
} >> "$BASE_DIR"/env/loki.env


if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$PROMTAIL_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$PROMTAIL_HOST\"" 
fi
