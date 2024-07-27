#!/usr/bin/env sh

# We are using a self-signed server cert because it's an experiment.
curl -s localhost:8080/local-server.crt > local-server.pem
curl --cert cert.pem \
    --key key.pem \
    --cacert local-server.pem \
    https://localhost:8443
rm local-server.pem