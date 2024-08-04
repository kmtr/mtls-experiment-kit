#!/usr/bin/env sh
if [ -z "$CLIENT_ROLE_NAME" ]; then
    echo "required: export CLIENT_ROLE_NAME" 1>&2
    exit 1
fi
if [ -z "$COMMON_NAME" ]; then
    COMMON_NAME="$CLIENT_ROLE_NAME".localhost
fi
TTL="24h"
CLIENT_CA_FILE=client-ca.pem
CLIENT_CERT_FILE=cert.pem
CLIENT_KEY_FILE=key.pem

RESPONSE=$(curl --silent \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request POST \
    --data '{"common_name": "'"$COMMON_NAME"'", "ttl": "'"$TTL"'"}' \
    "$VAULT_ADDR/v1/pki/issue/$CLIENT_ROLE_NAME")

printf "Issuing CA:\n"
printf "%s" "$RESPONSE" | jq -r .data.issuing_ca | tee "$CLIENT_CA_FILE"
printf "exported to %s\n\n" "$CLIENT_CA_FILE"
printf "Certificate:\n"
printf "%s" "$RESPONSE" | jq -r .data.certificate | tee "$CLIENT_CERT_FILE"
printf "exported to %s\n\n" "$CLIENT_CERT_FILE"
printf "Private Key:\n"
printf "%s" "$RESPONSE" | jq -r .data.private_key | tee "$CLIENT_KEY_FILE"
printf "exported to %s\n\n" "$CLIENT_KEY_FILE"
printf "Serial Number:\n"
printf "%s" "$RESPONSE" | jq -r .data.serial_number
