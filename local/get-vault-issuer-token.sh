#!/usr/bin/env sh

# usage: export VAULT_TOKEN=$(./get-vault-issuer-token.sh)
curl --silent \
    --request POST \
    --data '{"password": "'"$VAULT_ISSUER_PASSWORD"'"}' \
    "$VAULT_ADDR/v1/auth/userpass/login/$VAULT_ISSUER_USERNAME" \
    | jq -r .auth.client_token
