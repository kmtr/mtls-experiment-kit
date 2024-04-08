#!/usr/bin/env sh

ENVOY_URL=https://localhost:8481

# We are using a self-signed server cert because it's an experiment.
SERVER_CERT="local-server-envoy.pem"
./get-server-cert-from-envoy-container.sh > "$SERVER_CERT"
curl --cert cert.pem \
    --key key.pem \
    --cacert "$SERVER_CERT" \
    "$ENVOY_URL"
rm "$SERVER_CERT"