# mTLS: Nginx + Vault

This is just for the experiment.
Don't use for production.

## Getting Start

```sh
% docker compose up --build
% docker compose exec -it nginx sh
% docker compose exec -it vault sh
```

## Create a new client cert

```sh
% cd local
% export VAULT_TOKEN=$(sh token.sh)
% CLIENT_ROLE_NAME=client_a sh create-client-role.sh # create a client
% CLIENT_ROLE_NAME=client_a sh issue-cert.sh
Certificate:
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----

Issuing CA:
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----

Private Key:
-----BEGIN EC PRIVATE KEY-----
...
-----END EC PRIVATE KEY-----
```

## mTLS communication

Create certificate and key files.

```sh
% ls *.pem
ca.pem   cert.pem key.pem
% sh mtls-request.sh
Hello, Vault + Nginx mTLS%

% curl https://localhost:8443
curl: (60) SSL certificate problem: self signed certificate
```

## Revoke a certification

```sh
% sh revoke-cert.sh cert.pem
% # update crl.crt in vault and run `nginx -s reload`
% sh mtls-request.sh
404
```
