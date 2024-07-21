# issuer-admin-policy.hcl
path "sys/policies/acl/*" {
  capabilities = ["create", "update", "read", "delete"]
}

path "auth/userpass/users/*" {
  capabilities = ["create", "update", "read", "delete"]
}

path "auth/token/create" {
  capabilities = ["update"]
}

path "auth/token/lookup-self" {
  capabilities = ["read"]
}
