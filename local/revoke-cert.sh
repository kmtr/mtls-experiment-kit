#!/usr/bin/env sh
VAULT_ADDR="http://127.0.0.1:8200"
if [ -z "$VAULT_TOKEN" ]; then
    echo "required: export VAULT_TOKEN" 1>&2
    exit 1
fi
SERIAL=$(bash get-serial-number-from-cert.sh "$1")
curl --header "X-Vault-Token: $VAULT_TOKEN" \
     --request POST \
     --data '{"serial_number": "'"$SERIAL"'"}' \
     $VAULT_ADDR/v1/pki/revoke

# after revoking, update crl.crt in vault and run `nginx -s reload`
