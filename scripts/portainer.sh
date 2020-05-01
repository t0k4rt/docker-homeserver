# Portainer
PORTAINER_DEFAULT_HOST="portainer.$DOMAIN"

SUBJECT="Portainer host (default ${PORTAINER_DEFAULT_HOST})"
PORTAINER_HOST=$(ask_value_with_default "$SUBJECT" "$PORTAINER_DEFAULT_HOST" "$PORTAINER_HOST")

rm $BASE_DIR/env/portainer.env 2> /dev/null
echo PORTAINER_HOST=${PORTAINER_HOST} >> $BASE_DIR/env/portainer.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$PORTAINER_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$PORTAINER_HOST\"" 
fi