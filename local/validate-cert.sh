# validate the cert
openssl x509 -in cert.pem -pubkey -noout | openssl md5
openssl ec -in key.pem -pubout | openssl md5
