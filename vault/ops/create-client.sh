if [ -z "$CLIENT_ROLE_NAME" ]; then
    echo "required: export CLIENT_ROLE_NAME"
    exit 1
fi
if [ -z "$CLIENT_ORGANIZATION"]; then
    CLIENT_ORGANIZATION="client org"
fi
MAX_TTL="72h"

vault write pki/roles/"$CLIENT_ROLE_NAME" \
    allowed_domains="localhost" \
    allow_subdomains=true \
    max_ttl="$MAX_TTL" \
    ttl="1h" \
    key_type="ec" \
    key_bits=256 \
    allow_any_name=true \
    organization="$CLIENT_ORGANIZATION" \
    generate_lease=true
