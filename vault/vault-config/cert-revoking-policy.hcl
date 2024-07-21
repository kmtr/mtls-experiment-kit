path "pki/crl/*" {
  capabilities = ["read"]
}

path "pki/revoke" {
  capabilities = ["update"]
}

path "pki/certs/revoked" {
  capabilities = ["list"]
}