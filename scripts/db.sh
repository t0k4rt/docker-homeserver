# DB
if [ -z "$NEXTCLOUD_PASSWORD" ]; then
    echo "DB depends on nextcloud package, source nextcloud first"
    break
fi

POSTGRES_ADMIN_PASSWORD=$(ask_value "Postgres admin password" "$POSTGRES_ADMIN_PASSWORD")
echo ""

cat $BASE_DIR/db/init.tpl.sql | sed -e "s|{{NEXTCLOUD_PASSWORD}}|$NEXTCLOUD_PASSWORD|g;" > $BASE_DIR/db/init.sql
rm $BASE_DIR/env/db.env 2> /dev/null
echo POSTGRES_ADMIN_PASSWORD=${POSTGRES_ADMIN_PASSWORD} >> $BASE_DIR/env/db.env
