# usage: export SERIAL=$(bash get-serial-number.sh cert.pem)
openssl x509 -in "$1" -noout -serial | cut -d'=' -f2 | sed 's/../&:/g;s/:$//'
