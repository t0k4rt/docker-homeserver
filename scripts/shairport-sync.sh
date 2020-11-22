# Shairport

rm "$BASE_DIR"/env/shairport.env 2> /dev/null
SNAPCAST_CONFIG_DIR="$CONFIG_DIR/shairport-sync"

{
    echo SHAIRPORT_CONFIG_DIR=${SNAPCAST_CONFIG_DIR}

} >> "$BASE_DIR"/env/shairport-sync.env

