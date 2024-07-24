#!/bin/sh

VAULT_ADDR="http://127.0.0.1:8200"

if [ -z "$VAULT_TOKEN" ]; then
    echo "required: export VAULT_TOKEN"
    exit 1
fi
if [ -z "$CLIENT_ROLE_NAME" ]; then
    echo "required: export CLIENT_ROLE_NAME"
    exit 1
fi
if [ -z "$CLIENT_ORGANIZATION"]; then
    CLIENT_ORGANIZATION="client org"
fi
MAX_TTL="72h"


# クライアントロールの作成
curl --header "X-Vault-Token: $VAULT_TOKEN" \
     --request POST \
     --data '{
       "allowed_domains": "localhost",
       "allow_subdomains": true,
       "max_ttl": "'"$MAX_TTL"'",
       "key_type": "ec",
       "key_bits": 256,
       "allow_any_name": true,
       "organization": "'"$CLIENT_ORGANIZATION"'",
       "generate_lease": true
     }' \
     $VAULT_ADDR/v1/pki/roles/$CLIENT_ROLE_NAME

