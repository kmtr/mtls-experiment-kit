#!/usr/bin/env sh

SERIAL=$(bash get-serial-number-from-cert.sh "$1")
curl --header "X-Vault-Token: $VAULT_TOKEN" \
     --request POST \
     --data '{"serial_number": "'"$SERIAL"'"}' \
     $VAULT_ADDR/v1/pki/revoke

# after revoking, update crl.pem in vault and run `nginx -s reload`
