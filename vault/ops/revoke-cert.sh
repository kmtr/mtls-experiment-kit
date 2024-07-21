# get the serial number
openssl x509 -in cert.pem -noout -serial | sed 's/serial=//; s/../&:/g; s/:$//'

# check the cert
vault read pki/cert/{serial number}

# revoke
vault write pki/revoke serial_number={serial number}
vault list /pki/certs/revoked