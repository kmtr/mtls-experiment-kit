FROM hashicorp/vault:1.17.2

COPY vault-config /vault/config

COPY init.sh /vault/init.sh
COPY entrypoint.sh /vault/entrypoint.sh
RUN chmod +x /vault/init.sh /vault/entrypoint.sh

ENTRYPOINT ["/vault/entrypoint.sh"]