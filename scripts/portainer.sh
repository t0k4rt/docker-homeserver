# Portainer
PORTAINER_HOST="portainer.$DOMAIN"

SUBJECT="Portainer host (default ${PORTAINER_HOST})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $PORTAINER_HOST"
        break
    else
        PORTAINER_HOST="$value"
        break
    fi
done
echo ""

rm $BASE_DIR/env/portainer.env || true
echo PORTAINER_HOST=${PORTAINER_HOST} >> $BASE_DIR/env/portainer.env

if [ -z HOST_LIST ]; then 
    HOST_LIST="\"$PORTAINER_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$PORTAINER_HOST\"" 
fi