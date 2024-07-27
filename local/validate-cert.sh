#!/usr/bin/env sh

CERT_MD5=$(openssl x509 -in cert.pem -pubkey -noout | md5sum | cut -d' ' -f1)
KEY_MD5=$(openssl ec -in key.pem -pubout | md5sum | cut -d' ' -f1)

echo "certification md5 hash: $CERT_MD5"
echo "secret key    md5 hash: $KEY_MD5"
if [ "$CERT_MD5" = "$KEY_MD5" ]; then
    echo "ok"
else
    echo "error"
fi
