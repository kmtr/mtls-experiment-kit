#!/usr/bin/env sh
if [ -z "$SERIAL" ]; then
    echo "required: SERIAL" 1>&2
    echo "usage: SERIAL=\$(./get-serial-number-from-cert.sh cert.pem) ./get-cert-from-ca.sh" 1>&2
    exit 1
fi
RESPONSE=$(curl -s "$VAULT_ADDR/v1/pki/cert/$SERIAL")

REVOCATION_TIME=$(printf "%s" "$RESPONSE" | jq -r .data.revocation_time_rfc3339)
if [ -z "$REVOCATION_TIME" ]; then
    REVOCATION_TIME="NOT REVOCATED"
fi

echo "Certificate:"
printf "%s" "$RESPONSE" | jq -r .data.certificate
echo
echo "Revocation time RFC3339:"
echo "$REVOCATION_TIME"
