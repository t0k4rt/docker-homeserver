#  Treafik

SUBJECT="Let's encrypt email"
LETSENCRYPT_MAIL=$(ask_value "$SUBJECT" "$LETSENCRYPT_MAIL")


TRAEFIK_CONF_DIR="${CONFIG_DIR}/traefik"
TRAEFIK_CONF_FILE="${TRAEFIK_CONF_DIR}/traefik.toml"
TRAEFIK_LETSENCRYPT_FILE="${TRAEFIK_CONF_DIR}/acme.json"

mkdir -p "$TRAEFIK_CONF_DIR"
if [ -d "$TRAEFIK_CONF_FILE" ]; then 
    rm "$TRAEFIK_CONF_FILE"
fi

if [ ! -e "$TRAEFIK_CONF_FILE" ]; then 
    touch "$TRAEFIK_CONF_FILE"
    mv "$BASE_DIR/traefik/traefik.toml" "$TRAEFIK_CONF_FILE"
fi

if [ -d "$TRAEFIK_LETSENCRYPT_FILE" ]; then 
    rm "$TRAEFIK_LETSENCRYPT_FILE"
fi
if [ ! -e "$TRAEFIK_LETSENCRYPT_FILE" ]; then 
    touch "$TRAEFIK_LETSENCRYPT_FILE"
fi
chmod 600 "$TRAEFIK_LETSENCRYPT_FILE"

rm "$BASE_DIR"/env/traefik.env 2> /dev/null
{
    echo TRAEFIK_CONF_FILE="${TRAEFIK_CONF_FILE}"
    echo TRAEFIK_LETSENCRYPT_FILE="${TRAEFIK_LETSENCRYPT_FILE}"
    echo LETSENCRYPT_MAIL="${LETSENCRYPT_MAIL}"
} >> "$BASE_DIR"/env/traefik.env

echo "Traefik has been enabled for these hosts: $HOST_LIST"

# Traefik
cat "$BASE_DIR/traefik/traefik.tpl.toml" | sed -e "s|{{LETSENCRYPT_MAIL}}|$LETSENCRYPT_MAIL|g;s|{{HOST_LIST}}|$HOST_LIST|g;s|{{DOMAIN}}|$DOMAIN|g" > $TRAEFIK_CONF_FILE