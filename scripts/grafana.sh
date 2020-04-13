# Transmission

GRAFANA_HOST="grafana.$DOMAIN"

SUBJECT="Grafana host (default ${GRAFANA_HOST})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $GRAFANA_HOST"
        break
    else
        GRAFANA_HOST="$value"
        break
    fi
done
echo ""

rm $BASE_DIR/env/grafana.env 2> /dev/null
GRAFANA_CONFIG_DIR="$CONFIG_DIR/grafana/config"
GRAFANA_PLUGIN_DIR="$CONFIG_DIR/grafana/plugins"

echo GRAFANA_HOST=${GRAFANA_HOST} >> $BASE_DIR/env/grafana.env
echo GRAFANA_CONFIG_DIR=${GRAFANA_CONFIG_DIR} >> $BASE_DIR/env/grafana.env
echo GRAFANA_PLUGIN_DIR=${GRAFANA_PLUGIN_DIR} >> $BASE_DIR/env/grafana.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$GRAFANA_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$GRAFANA_HOST\"" 
fi
