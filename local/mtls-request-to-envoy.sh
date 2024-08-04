#!/usr/bin/env sh

ENVOY_URL=https://localhost:8481

SERVER_CERT="local-server-envoy.pem"
docker compose exec envoy openssl x509 -in /etc/envoy/server/local-server.crt > "$SERVER_CERT"

# We are using a self-signed server cert because it's an experiment.
curl --cert cert.pem \
    --key key.pem \
    --cacert "$SERVER_CERT" \
    "$ENVOY_URL"
rm "$SERVER_CERT"
