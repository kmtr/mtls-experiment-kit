#!/bin/sh

# Vaultのエンドポイントとトークン
export VAULT_ADDR='http://127.0.0.1:8200'

# 初期化状態を確認
vault status

# Vaultにログイン
if ! vault login "$VAULT_DEV_ROOT_TOKEN_ID"; then
    echo "error: vault login"
    exit 1
fi

# PKIシークレットエンジンの有効化
if ! vault secrets enable pki; then
    echo "error: secrets enable pki"
    exit 1
fi

# 証明書発行の最大TTLを設定
if ! vault secrets tune -max-lease-ttl=87600h pki; then
    echo "error: secrets tune"
    exit 1
fi

# ルートCA証明書を生成
if ! vault write pki/root/generate/internal \
    common_name="localhost" \
    ttl=87600h; then
    echo "error: write pki/root/generate/internal"
    exit 1
fi

# 証明書の配布用URLの設定
if ! vault write pki/config/urls \
    issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \
    crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl"; then
    echo "error: write pki/config/urls"
    exit 1
fi

write_policy() {
    if ! vault policy write "$1" "/vault/config/$1.hcl"; then
        echo "error: write $1"
        exit 1
    fi
}
write_policy client-management-policy
write_policy cert-issuing-policy
write_policy cert-revoking-policy
write_policy cert-reading-policy

vault auth enable userpass
vault write auth/userpass/users/devissuer \
    password="iss" \
    policies="client-management-policy,cert-issuing-policy,cert-revoking-policy,cert-reading-policy"

if ! vault read -format=table -field=certificate pki/cert/ca \
    > /vault/file/ca.crt; then
    echo "error: export ca.crt"
    exit 1
fi
if vault read -format=table -field=certificate pki/cert/crl \
    > /vault/file/crl.pem; then
    echo "error: export crl.pem"
    exit 1
fi

echo "----------------"
echo "Vault Init: Done"
echo "----------------"
