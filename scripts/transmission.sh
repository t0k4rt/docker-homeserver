# Transmission

TRANSMISSION_HOST="transmission.$DOMAIN"

SUBJECT="Transmission host (default ${TRANSMISSION_HOST})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $TRANSMISSION_HOST"
        break
    else
        TRANSMISSION_HOST="$value"
        break
    fi
done
echo ""

rm $BASE_DIR/env/transmission.env 2> /dev/null
TRANSMISSION_CONFIG_DIR="$CONFIG_DIR/transmission"

echo TRANSMISSION_HOST=${TRANSMISSION_HOST} >> $BASE_DIR/env/transmission.env
echo TRANSMISSION_CONFIG_DIR=${TRANSMISSION_CONFIG_DIR} >> $BASE_DIR/env/transmission.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$TRANSMISSION_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$TRANSMISSION_HOST\"" 
fi
