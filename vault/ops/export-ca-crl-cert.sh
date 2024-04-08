vault read -format=table -field=certificate pki/cert/ca > /vault/file/ca.crt
vault read -format=table -field=certificate pki/cert/crl > /vault/file/crl.pem
