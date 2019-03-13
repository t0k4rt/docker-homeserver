# Jellyfin

JELLYFIN_HOST="jellyfin.$DOMAIN"

SUBJECT="Jellyfin host (default ${JELLYFIN_HOST})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $JELLYFIN_HOST"
        break
    else
        JELLYFIN_HOST="$value"
        break
    fi
done
echo ""

rm $BASE_DIR/env/jellyfin.env || true
JELLYFIN_CONFIG_DIR="$CONFIG/jellyfin"

echo JELLYFIN_HOST=${JELLYFIN_HOST} >> $BASE_DIR/env/jellyfin.env
echo JELLYFIN_CONFIG_DIR=${JELLYFIN_CONFIG_DIR} >> $BASE_DIR/env/jellyfin.env

if [ -z HOST_LIST ]; then 
    HOST_LIST="\"$JELLYFIN_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$JELLYFIN_HOST\"" 
fi