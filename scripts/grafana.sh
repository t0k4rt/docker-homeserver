# Grafana
rm "$BASE_DIR"/env/grafana.env 2> /dev/null

GRAFANA_DEFAULT_HOST="grafana.$DOMAIN"

SUBJECT="Grafana host (default ${GRAFANA_DEFAULT_HOST})"
GRAFANA_HOST=$(ask_value_with_default "$SUBJECT" "$GRAFANA_DEFAULT_HOST" "$GRAFANA_HOST")

GRAFANA_CONFIG_DIR="$CONFIG_DIR/grafana/config"
GRAFANA_PLUGIN_DIR="$CONFIG_DIR/grafana/plugins"

{
    echo GRAFANA_HOST="${GRAFANA_HOST}" 
    echo GRAFANA_CONFIG_DIR="${GRAFANA_CONFIG_DIR}"
    echo GRAFANA_PLUGIN_DIR="${GRAFANA_PLUGIN_DIR}"
} >> "$BASE_DIR"/env/grafana.env


if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$GRAFANA_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$GRAFANA_HOST\"" 
fi
