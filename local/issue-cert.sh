#!/usr/bin/env sh
VAULT_ADDR="http://127.0.0.1:8200"
COMMON_NAME="server.example.com"
TTL="24h"

if [ -z "$VAULT_TOKEN" ]; then
    echo "required: export VAULT_TOKEN" 1>&2
    exit 1
fi
if [ -z "$CLIENT_ROLE_NAME" ]; then
    echo "required: export CLIENT_ROLE_NAME" 1>&2
    exit 1
fi

RESPONSE=$(curl --silent --header "X-Vault-Token: $VAULT_TOKEN" --request POST --data '{"common_name": "'"$COMMON_NAME"'", "ttl": "'"$TTL"'"}' "$VAULT_ADDR/v1/pki/issue/$CLIENT_ROLE_NAME")

echo "Issuing CA:"
printf "%s" "$RESPONSE" | jq -r .data.issuing_ca
echo
echo "Certificate:"
printf "%s" "$RESPONSE" | jq -r .data.certificate
echo
echo "Private Key:"
printf "%s" "$RESPONSE" | jq -r .data.private_key
echo
echo "Serial Number:"
printf "%s" "$RESPONSE" | jq -r .data.serial_number
