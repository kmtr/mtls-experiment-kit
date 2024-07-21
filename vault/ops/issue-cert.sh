vault write --format=json pki/issue/client_x \
    common_name="clientA.example.com" \
    ttl="1h"

vault read --format=table --field certificate pki/cert/{serial number}
vault read --format=json pki/cert/{serial number}
