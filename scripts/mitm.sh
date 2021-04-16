# Mitm
rm "$BASE_DIR"/env/mitm.env 2> /dev/null

MITM_DEFAULT_HOST="mitm.$DOMAIN"

SUBJECT="Mitm host (default ${MITM_DEFAULT_HOST})"
MITM_HOST=$(ask_value_with_default "$SUBJECT" "$MITM_DEFAULT_HOST" "$MITM_HOST")

MITM_CONFIG_DIR="$CONFIG_DIR/mitm/config"

{
    echo MITM_HOST="${MITM_HOST}" 
    echo MITM_CONFIG_DIR="${MITM_CONFIG_DIR}"
} >> "$BASE_DIR"/env/shaarli.env


if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$MITM_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$MITM_HOST\"" 
fi
