# DB
if [ -z "$NEXTCLOUD_PASSWORD" ]; then
    echo "DB depends on nextcloud package, source nextcloud first"
    break
fi

POSTGRES_ADMIN_PASSWORD=""

SUBJECT="Postgres admin password"
while true; do
    read -p "$SUBJECT: " POSTGRES_ADMIN_PASSWORD
    if [ -z "$POSTGRES_ADMIN_PASSWORD" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""

cat $BASE_DIR/db/init.tpl.sql | sed -e "s|{{NEXTCLOUD_PASSWORD}}|$NEXTCLOUD_PASSWORD|g;" > $BASE_DIR/db/init.sql
rm $BASE_DIR/env/db.env 2> /dev/null
echo POSTGRES_ADMIN_PASSWORD=${POSTGRES_ADMIN_PASSWORD} >> $BASE_DIR/env/db.env
