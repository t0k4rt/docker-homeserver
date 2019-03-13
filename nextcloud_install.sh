
#!/bin/bash

# todo:
# find nextcloud container 
# log in to container wth PUID
# execute create user commande

$NEXTCLOUD_ADMIN_USER="tok"
$NEXTCLOUD_ADMIN_PASSWORD="plop"

# todo: ask for admin user / password
/var/www/nextcloud/
php occ  maintenance:install --database "pgsql" \
    --database-name "$NEXTCLOUD_DB" \
    --database-user "$NEXTCLOUD_DB_USER" \
    --database-pass "$NEXTCLOUD_PASSWORD" \
    --admin-user "$NEXTCLOUD_ADMIN_USER" \
    --admin-pass "$NEXTCLOUD_ADMIN_PASSWORD"


# todo create filer user
NEXTCLOUD_PASSWORD=""
NEXTCLOUD_DB="nextcloud"
NEXTCLOUD_DB_USER="nextcloud"
NEXTCLOUD_DATA=""
NEXTCLOUD_FILER_USER="grosfichier"
NEXTCLOUD_FILER_PASSWORD="$ADMIN_PASSWORD"