#!/bin/sh

if [ -z "$SERIAL" ]; then
    echo "usage: SERIAL={serial_number} ./show-cert.sh"
    exit 1
fi
vault read --format=table "pki/cert/$SERIAL"