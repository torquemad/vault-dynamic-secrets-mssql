#!/bin/sh -x                                                                                                                                     
export VAULT_ADDR=http://127.0.0.1:8200
vault server -config /vault/config/vault.conf > /vault.out 2>&1 &

sleep 10

if [[ ! -e /key.txt ]]; then
    /usr/local/bin/configure_once.sh
fi

export VAULT_TOKEN=$(cat /token.txt)
tail -f /vault.out

