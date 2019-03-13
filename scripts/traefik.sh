#  Treafik
LETSENCRYPT_MAIL=""

SUBJECT="Let's encrypt email"
while true; do
    read -p "$SUBJECT: " LETSENCRYPT_MAIL
    if [ -z "$LETSENCRYPT_MAIL" ]; then
        echo "$SUBJECT cannot be empty, try again"
    else
        break
    fi
done
echo ""

TRAEFIK_CONF_DIR="${CONFIG_DIR}/traefik"
TRAEFIK_CONF_FILE="${TRAEFIK_CONF_DIR}/traefik.toml"
TRAEFIK_LETSENCRYPT_FILE="${TRAEFIK_CONF_DIR}/acme.json"

echo $TRAEFIK_CONF_FILE
mkdir -p $TRAEFIK_CONF_DIR
if [ -d $TRAEFIK_CONF_FILE ]; then 
    rm $TRAEFIK_CONF_FILE
fi
if [ ! -e $TRAEFIK_CONF_FILE ]; then 
    touch $TRAEFIK_CONF_FILE
    mv traefik/traefik.toml $TRAEFIK_CONF_FILE
fi

echo $TRAEFIK_LETSENCRYPT_FILE
if [ -d $TRAEFIK_LETSENCRYPT_FILE ]; then 
    rm $TRAEFIK_LETSENCRYPT_FILE
fi
if [ ! -e $TRAEFIK_LETSENCRYPT_FILE ]; then 
    touch $TRAEFIK_LETSENCRYPT_FILE
fi
chmod 600 $TRAEFIK_LETSENCRYPT_FILE

rm $BASE_DIR/env/traefik.env || true
echo TRAEFIK_CONF_FILE=${TRAEFIK_CONF_FILE} >> $BASE_DIR/env/traefik.env
echo TRAEFIK_LETSENCRYPT_FILE=${TRAEFIK_LETSENCRYPT_FILE} >> $BASE_DIR/env/traefik.env

echo "Traefik has been enabled for these hosts: $HOST_LIST"

# Traefik
cat $BASE_DIR/traefik/traefik.tpl.toml | sed -e "s|{{LETSENCRYPT_MAIL}}|$LETSENCRYPT_MAIL|g;s|{{HOST_LIST}}|$HOST_LIST|g" > $BASE_DIR/traefik/traefik.toml
