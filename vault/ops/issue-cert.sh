if [ -z "$CLIENT_ROLE_NAME" ]; then
    echo "required: export CLIENT_ROLE_NAME"
    exit 1
fi
vault write --format=json pki/issue/"$CLIENT_ROLE_NAME" \
    common_name="clientA.example.com" \
    ttl="1h"

vault read --format=table --field certificate pki/cert/{serial number}
vault read --format=json pki/cert/{serial number}
