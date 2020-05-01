# Samba

rm $BASE_DIR/env/samba.env 2> /dev/null

SAMBA_DEFAULT_TOK_USER="tok"

SUBJECT="Samba tok personal dir"
SAMBA_TOK_DATA=$(ask_value "$SUBJECT" "$SAMBA_TOK_DATA")

SUBJECT="Samba tok user (Default ${SAMBA_DEFAULT_TOK_USER})"
SAMBA_TOK_USER=$(ask_value_with_default "$SUBJECT" "$SAMBA_DEFAULT_TOK_USER" "$SAMBA_TOK_USER")

SUBJECT="Samba tok password"
SAMBA_TOK_PASSWORD=$(ask_value "$SUBJECT" "$SAMBA_TOK_PASSWORD")

{
    echo SAMBA_TOK_USER=${SAMBA_TOK_USER}
    echo SAMBA_TOK_PASSWORD=${SAMBA_TOK_PASSWORD}
    echo SAMBA_TOK_DATA=${SAMBA_TOK_DATA}
} >> $BASE_DIR/env/samba.env
