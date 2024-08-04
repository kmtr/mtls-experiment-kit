path "pki/issue/*" {
  capabilities = ["create", "update", "read"]
}

path "pki/sign/*" {
  capabilities = ["update"]
}
