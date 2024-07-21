vault write pki/roles/clientA-role \
    allowed_domains="localhost" \
    allow_subdomains=true \
    max_ttl="24h" \
    ttl="1h" \
    key_type="ec" \
    key_bits=256 \
    allow_any_name=true \
    organization="Client A Organization" \
    generate_lease=true
