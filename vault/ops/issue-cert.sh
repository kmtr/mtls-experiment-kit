#!/bin/sh

if [ -z "$CLIENT_ROLE_NAME" ]; then
    echo "usage: CLIENT_ROLE_NAME={client-role-name}" ./issue-cert.sh
    exit 1
fi
if [ -z "$COMMON_NAME" ]; then
    COMMON_NAME="$CLIENT_ROLE_NAME"
fi
if [ -z "$TTL" ]; then
    TTL="1h"
fi
vault write --format=table pki/issue/"$CLIENT_ROLE_NAME" \
    common_name="$COMMON_NAME" \
    ttl="$TTL"
