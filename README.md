# mTLS Experiment Kit

This is just for the experiment.
Don't use for production.

## Getting Start

```sh
% docker compose up --build
% docker compose exec -it vault sh
% docker compose exec -it nginx bash
% docker compose exec -it envoy bash
```

## Create a new client cert

```sh
% cd local
% source ./env-local
% export VAULT_TOKEN=$(./get-vault-issuer-token.sh)
% # create a client role in Vault
% CLIENT_ROLE_NAME=client_a ./create-client-role.sh 
```

## Issue a certtification with CSR

```sh
% # issue a certification
% CLIENT_ROLE_NAME=client-a ./issue-cert-with-csr.sh
% ls *.pem
cert.pem csr.pem  key.pem
% ./mtls-request-to-nginx.sh
Hello, mTLS
% 
```


## Issue a certification without CSR

```sh
% # issue a certification
% CLIENT_ROLE_NAME=client_a ./issue-cert.sh
% ls *.pem
cert.pem      client-ca.pem key.pem
% ./mtls-request-to-nginx.sh
Hello, mTLS
% 
```

## mTLS communication

```sh
% ls cert.pem key.pem
% ./mtls-request-to-nginx.sh
Hello, mTLS
% ./mtls-request-to-envoy.sh
Hello, mTLS
% # you'll get the error without the certification and the key
% curl https://localhost:8443
curl: (60) SSL certificate problem: self signed certificate
```

## Revoke a certification

```sh
% ./revoke-cert.sh cert.pem
% # update crl.pem
% docker compose exec -ti vault sh
$ vault read -format=table -field=certificate pki/cert/crl > /vault/file/crl.pem
$ exit
% # reload nginx configuration `nginx -s reload`
% docker compose exec nginx bash
$ nginx -s reload
$ exit
% ./mtls-request-to-nginx.sh
404 error
% docker compose restart envoy
% ./mtls-request-to-envoy.sh
404 error
```
