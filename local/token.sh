#!/usr/bin/env sh

# usage: export VAULT_TOKEN=$(bash local/token.sh)
VAULT_ADDR="http://127.0.0.1:8200"
USERNAME=devissuer
PASSWORD=iss

VAULT_TOKEN=$(curl --silent --request POST --data '{"password": "'"$PASSWORD"'"}' $VAULT_ADDR/v1/auth/userpass/login/$USERNAME | jq -r .auth.client_token)
echo "$VAULT_TOKEN"
