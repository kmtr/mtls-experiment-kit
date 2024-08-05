#!/bin/sh

openssl x509 -in cert.pem -noout -serial | sed 's/serial=//; s/../&:/g; s/:$//'
