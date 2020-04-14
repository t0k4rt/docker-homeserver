# Samba

rm $BASE_DIR/env/samba.env 2> /dev/null

SAMBA_TOK_USER="tok"

SUBJECT="Samba tok personal dir"
while true; do
    read -p "$SUBJECT: " SAMBA_TOK_DATA
    if [ -z "$SAMBA_TOK_DATA" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""

SUBJECT="Samba tok user (Default ${SAMBA_TOK_USER})"
while true; do
    read -p "$SUBJECT: " value
    if [ -z "$value" ]; then
        echo "Using default $SUBJECT: $SAMBA_TOK_USER"
        break
    else
        SAMBA_TOK_USER="$value"
        break
    fi
done
echo ""

SUBJECT="Samba tok password"
while true; do
    read -p "$SUBJECT: " SAMBA_TOK_PASSWORD
    if [ -z "$SAMBA_TOK_PASSWORD" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""

echo SAMBA_TOK_USER=${SAMBA_TOK_USER} >> $BASE_DIR/env/influxdb.env
echo SAMBA_TOK_PASSWORD=${SAMBA_TOK_PASSWORD} >> $BASE_DIR/env/influxdb.env
echo SAMBA_TOK_DATA=${SAMBA_TOK_DATA} >> $BASE_DIR/env/samba.env
