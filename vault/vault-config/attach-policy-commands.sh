# login
vault login -method=userpass username=devissuer password=iss

# update policy
vault policy write client-management-policy /vault/config/client-management-policy.hcl
vault policy write cert-issuing-policy /vault/config/cert-issuing-policy.hcl
vault policy write cert-revoking-policy /vault/config/cert-revoking-policy.hcl
vault policy write cert-reading-policy /vault/config/cert-reading-policy.hcl


# retach policies
vault write auth/userpass/users/devissuer policies="client-management-policy,cert-issuing-policy,cert-revoking-policy,cert-reading-policy"