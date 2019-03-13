# Jackett

JACKETT_HOST="jackett.$DOMAIN"

SUBJECT="Jackett host (default ${JACKETT_HOST})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $JACKETT_HOST"
        break
    else
        JACKETT_HOST="$value"
        break
    fi
done
echo ""

rm $BASE_DIR/env/jackett.env || true
JACKETT_CONFIG_DIR="$CONFIG/jackett"

echo JACKETT_HOST=${JACKETT_HOST} >> $BASE_DIR/env/jackett.env
echo JACKETT_CONFIG_DIR=${JACKETT_CONFIG_DIR} >> $BASE_DIR/env/jackett.env

if [ -z HOST_LIST ]; then 
    HOST_LIST="\"$JACKETT_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$JACKETT_HOST\"" 
fi