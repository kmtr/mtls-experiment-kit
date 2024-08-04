#!/usr/bin/env sh

NGINX_URL=https://localhost:8443

# We are using a self-signed server cert because it's an experiment.
SERVER_CERT="local-server-nginx.pem"
curl -s localhost:8080/local-server.crt > "$SERVER_CERT"
curl --cert cert.pem \
    --key key.pem \
    --cacert "$SERVER_CERT" \
    "$NGINX_URL"
rm "$SERVER_CERT"
