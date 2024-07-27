#!/usr/bin/env sh

if [ -z "$1" ]; then
    echo "usage: ./get-serial-number-from-cert.sh cert.pem" 1>&2
    exit 1
fi
if [ ! -e "$1" ]; then
    echo "can't find the file: $1" 1>&2
    exit 1
fi
openssl x509 -in "$1" -noout -serial | cut -d'=' -f2 | sed 's/../&:/g;s/:$//'
