# Nextcloud
NEXTCLOUD_DEFAULT_HOST="nextcloud.$DOMAIN"
NEXTCLOUD_DB="nextcloud"
NEXTCLOUD_DB_USER="nextcloud"
NEXTCLOUD_FILER_USER="grosfichier"

SUBJECT="Nextcloud db password"
NEXTCLOUD_PASSWORD=$(ask_value "$SUBJECT" "$NEXTCLOUD_PASSWORD")

SUBJECT="Nextcloud DB name (Default ${NEXTCLOUD_DEFAULT_DB})"
NEXTCLOUD_DB=$(ask_value_with_default "$SUBJECT" "$NEXTCLOUD_DEFAULT_DB" "$NEXTCLOUD_DB")

SUBJECT="Nextcloud User (Default ${NEXTCLOUD_DEFAULT_DB_USER})"
NEXTCLOUD_DB_USER=$(ask_value_with_default "$SUBJECT" "$NEXTCLOUD_DEFAULT_DB_USER" "$NEXTCLOUD_DB_USER")

SUBJECT="Nextcloud host (default ${NEXTCLOUD_DEFAULT_HOST})"
NEXTCLOUD_HOST=$(ask_value_with_default "$SUBJECT" "$NEXTCLOUD_DEFAULT_HOST" "$NEXTCLOUD_HOST")

SUBJECT="Nextcloud data dir"
NEXTCLOUD_DATA=$(ask_value "$SUBJECT" "$NEXTCLOUD_DATA")

rm "$BASE_DIR"/env/nextcloud.env 2> /dev/null
NEXTCLOUD_CONFIG_DIR="$CONFIG_DIR/nextcloud"
NEXTCLOUD_NGINX_CONFIG_DIR="$CONFIG_DIR/nextcloud_nginx"
NEXTCLOUD_PHP_CONFIG_DIR="$CONFIG_DIR/nextcloud_php"
{
    echo NEXTCLOUD_PASSWORD="${NEXTCLOUD_PASSWORD}"
    echo NEXTCLOUD_DB="${NEXTCLOUD_DB}"
    echo NEXTCLOUD_DB_USER="${NEXTCLOUD_DB_USER}"
    echo NEXTCLOUD_DATA="${NEXTCLOUD_DATA}"
    echo NEXTCLOUD_HOST="${NEXTCLOUD_HOST}"
    echo NEXTCLOUD_FILER_USER="${NEXTCLOUD_FILER_USER}"
    echo NEXTCLOUD_CONFIG_DIR="${NEXTCLOUD_CONFIG_DIR}"
    echo NEXTCLOUD_NGINX_CONFIG_DIR="${NEXTCLOUD_NGINX_CONFIG_DIR}"
    echo NEXTCLOUD_PHP_CONFIG_DIR="${NEXTCLOUD_PHP_CONFIG_DIR}"
} >> "$BASE_DIR"/env/nextcloud.env

if [ -z "$HOST_LIST" ]; then 
    HOST_LIST="\"$NEXTCLOUD_HOST\"" 
else
    HOST_LIST="$HOST_LIST,\"$NEXTCLOUD_HOST\"" 
fi