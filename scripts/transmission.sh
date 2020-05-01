# Transmission

TRANSMISSION_DEFAULT_HOST="transmission.$DOMAIN"

SUBJECT="Transmission host (default ${TRANSMISSION_DEFAULT_HOST})"
TRANSMISSION_HOST=$(ask_value_with_default "$SUBJECT" "$TRANSMISSION_DEFAULT_HOST" "$TRANSMISSION_HOST")


rm "$BASE_DIR"/env/transmission.env 2> /dev/null
TRANSMISSION_CONFIG_DIR="$CONFIG_DIR/transmission"

{
    echo TRANSMISSION_HOST="${TRANSMISSION_HOST}"
    echo TRANSMISSION_CONFIG_DIR="${TRANSMISSION_CONFIG_DIR}"
} >> "$BASE_DIR"/env/transmission.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$TRANSMISSION_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$TRANSMISSION_HOST\"" 
fi
