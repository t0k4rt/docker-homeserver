# Samba

rm $BASE_DIR/env/samba.env 2> /dev/null


SUBJECT="Samba personal dir"
while true; do
    read -p "$SUBJECT: " SAMBA_DATA
    if [ -z "$SAMBA_DATA" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""

echo NEXTCLOUD_DATA=${SAMBA_DATA} >> $BASE_DIR/env/samba.env
