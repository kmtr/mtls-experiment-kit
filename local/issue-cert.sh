VAULT_ADDR="http://127.0.0.1:8200"
COMMON_NAME="server.example.com"
TTL="24h"

if [ -z "$VAULT_TOKEN" ]; then
    echo "required: export VAULT_TOKEN"
    exit 1
fi
if [ -z "$CLIENT_ROLE_NAME" ]; then
    echo "required: export CLIENT_ROLE_NAME"
    exit 1
fi

# 証明書の発行
RESPONSE=$(curl --silent --header "X-Vault-Token: $VAULT_TOKEN" --request POST --data '{"common_name": "'"$COMMON_NAME"'", "ttl": "'"$TTL"'"}' $VAULT_ADDR/v1/pki/issue/$CLIENT_ROLE_NAME)

# 出力
echo "Certificate:"
echo $RESPONSE | jq -r .data.certificate
echo
echo "Issuing CA:"
echo $RESPONSE | jq -r .data.issuing_ca
echo
echo "Private Key:"
echo $RESPONSE | jq -r .data.private_key
echo
echo "Serial Number:"
echo $RESPONSE | jq -r .data.serial_number
