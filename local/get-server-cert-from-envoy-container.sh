#!/bin/sh
docker compose exec envoy \
    openssl x509 -in /etc/envoy/server/local-server.crt

# this is a usage how to use this certification with curl.
# curl --cacert ./local-server.pem https://localhost:8481/