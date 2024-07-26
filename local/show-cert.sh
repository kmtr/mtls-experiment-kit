#!/usr/bin/env sh
if [ -z "$SERIAL" ]; then
    echo "required: export SERIAL"
    exit 1
fi
RESPONSE=$(curl -s http://127.0.0.1:8200/v1/pki/cert/"$SERIAL")

REVOCATION_TIME=$(printf "%s" "$RESPONSE" | jq -r .data.revocation_time_rfc3339)
if [ -z "$REVOCATION_TIME" ]; then
    REVOCATION_TIME="NOT REVOCATED"
fi

echo "Certificate:"
printf "%s" "$RESPONSE" | jq -r .data.certificate
echo
echo "Revocation time RFC3339:"
echo "$REVOCATION_TIME"
