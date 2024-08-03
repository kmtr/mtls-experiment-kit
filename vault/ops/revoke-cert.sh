if [ -z "$SERIAL" ]; then
    echo "usage: SERIAL={serial_number} ./revoke-cert.sh"
    exit 1
fi

# revoke
vault write pki/revoke serial_number="$SERIAL"
vault list /pki/certs/revoked