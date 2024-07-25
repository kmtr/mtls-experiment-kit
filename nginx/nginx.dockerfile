FROM nginx:1.27.0
COPY nginx.conf /etc/nginx/
COPY index.html /usr/share/nginx/html/
RUN mkdir -p /etc/nginx/ssl
RUN openssl ecparam -name prime256v1 -out /tmp/prime256v1.pem && \
    openssl req -x509 -nodes -days 365 \
    -newkey ec:/tmp/prime256v1.pem \
    -keyout /etc/nginx/ssl/local-server.key -out /etc/nginx/ssl/local-server.crt \
    -subj "/CN=localhost" \
    -addext "subjectAltName=DNS:localhost,IP:127.0.0.1" && \
    rm /tmp/prime256v1.pem
