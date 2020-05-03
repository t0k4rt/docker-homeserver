# Home Assistant
HASS_DEFAULT_HOST="hass.$DOMAIN"

SUBJECT="Home assistant host (default ${HASS_DEFAULT_HOST})"
HASS_HOST=$(ask_value_with_default "$SUBJECT" "$HASS_DEFAULT_HOST" "$HASS_HOST")


rm "$BASE_DIR"/env/HASS.env 2> /dev/null
HASS_CONFIG_DIR="$CONFIG_DIR/HASS"

{
    echo HASS_HOST="${HASS_HOST}"
    echo HASS_CONFIG_DIR="${HASS_CONFIG_DIR}"
} >> "$BASE_DIR"/env/sonarr.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$HASS_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$HASS_HOST\"" 
fi