FROM envoyproxy/envoy:v1.31-latest

COPY envoy.yaml /etc/envoy/envoy.yaml
COPY tls_certificate_sds_secret.yaml /etc/envoy/tls_certificate_sds_secret.yaml
COPY validation_context_sds_secret.yaml /etc/envoy/validation_context_sds_secret.yaml

RUN mkdir -p /etc/envoy/server && \
    openssl ecparam -name prime256v1 -out /tmp/prime256v1.pem && \
    openssl req -x509 -nodes -days 365 \
    -newkey ec:/tmp/prime256v1.pem \
    -out /etc/envoy/server/local-server.crt \
    -keyout /etc/envoy/server/local-server.key \
    -subj "/CN=localhost" \
    -addext "subjectAltName=DNS:localhost,IP:127.0.0.1" && \
    rm /tmp/prime256v1.pem && \
    chown envoy:envoy /etc/envoy/server/local-server.crt && \
    chown envoy:envoy /etc/envoy/server/local-server.key
