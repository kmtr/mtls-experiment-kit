#!/bin/bash

if [ -z "$CLIENT_ROLE_NAME" ]; then
    echo "required: export CLIENT_ROLE_NAME" 1>&2
    exit 1
fi
if [ -z "$COMMON_NAME" ]; then
    COMMON_NAME="$CLIENT_ROLE_NAME".localhost
fi
TTL="24h"

# Variables
CSR_FILE="csr.pem"
KEY_FILE="key.pem"
SIGNED_CERT_FILE="cert.pem"

# Generate EC private key using prime256v1 curve
openssl ecparam -name prime256v1 -genkey -noout -out $KEY_FILE

# Generate CSR using the private key
openssl req -new -key $KEY_FILE -out $CSR_FILE -subj "/CN=${COMMON_NAME}"

# Read CSR content and encode it in base64
CSR_CONTENT=$(cat $CSR_FILE | awk '{printf "%s\\n", $0}')

# Prepare CSR payload
cat <<EOF > csr_payload.json
{
  "csr": "$CSR_CONTENT",
  "format": "pem_bundle",
  "ttl": "43800h"
}
EOF

# Submit CSR to Vault and get the signed certificate
response=$(curl --silent --request POST \
     --url $VAULT_ADDR/v1/pki/sign/$CLIENT_ROLE_NAME \
     --header 'Content-Type: application/json' \
     --header "X-Vault-Token: $VAULT_TOKEN" \
     --data @csr_payload.json
)
rm csr_payload.json

# Extract signed certificate
signed_cert=$(echo $response | jq -r '.data.certificate')

# Save signed certificate to file
echo "$signed_cert" > $SIGNED_CERT_FILE

echo "CSR: $CSR_FILE"
echo "KEY: $KEY_FILE"
echo "Client certificate issued and saved to ${SIGNED_CERT_FILE}"
