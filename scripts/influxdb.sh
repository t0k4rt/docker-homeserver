# influxdb

rm $BASE_DIR/env/influxdb.env 2> /dev/null



SUBJECT="Infludb admin (Default ${INFLUXDB_ADMIN_USER})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $INFLUXDB_ADMIN_USER"
        break
    else
        NEXTCLOUD_DB_USER="$value"
        break
    fi
done
echo ""

SUBJECT="Infludb admin password"
while true; do
    read -p "$SUBJECT: " NEXTCLOUD_PASSWORD
    if [ -z "$INFLUXDB_ADMIN_PASSWORD" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""

echo INFLUXDB_ADMIN_USER=${INFLUXDB_ADMIN_USER} >> $BASE_DIR/env/influxdb.env
echo INFLUXDB_ADMIN_PASSWORD=${INFLUXDB_ADMIN_PASSWORD} >> $BASE_DIR/env/influxdb.env

INFLUDB_CONFIG_DIR="$CONFIG_DIR/influxdb"
echo INFLUDB_CONFIG_DIR=${INFLUDB_CONFIG_DIR} >> $BASE_DIR/env/influxdb.env