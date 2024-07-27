#!/usr/bin/env sh
if [ -z "$CLIENT_ROLE_NAME" ]; then
    echo "required: export CLIENT_ROLE_NAME" 1>&2
    exit 1
fi
if [ -z "$COMMON_NAME" ]; then
    COMMON_NAME="$CLIENT_ROLE_NAME".localhost
fi
TTL="24h"

RESPONSE=$(curl --silent \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request POST \
    --data '{"common_name": "'"$COMMON_NAME"'", "ttl": "'"$TTL"'"}' \
    "$VAULT_ADDR/v1/pki/issue/$CLIENT_ROLE_NAME")

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
