#!/bin/bash
# Author: Bhavyai Gupta


# initialize the vault server
INIT_DATA=$( curl -X POST -d '{"secret_shares": 1, "secret_threshold": 1}' http://127.0.0.1:8200/v1/sys/init 2> /dev/null)


# talk to vault server (not required when using REST API calls to interact with vault)
# export VAULT_ADDR='http://127.0.0.1:8200'


# store the root token and keys_base64
VAULT_TOKEN=$( echo $INIT_DATA | jq -r .root_token )
KEY_BASE64=$( echo $INIT_DATA | jq -r .keys_base64[0] )
echo ${VAULT_TOKEN} > vault_token.txt


# unseal the vault
curl -X POST -d "{\"key\": \"${KEY_BASE64}\"}" http://127.0.0.1:8200/v1/sys/unseal &> /dev/null


# enable key value store in vault
curl -H "X-Vault-Token: $VAULT_TOKEN" -X POST -d '{ "type":"kv-v2" }' http://127.0.0.1:8200/v1/sys/mounts/secret &> /dev/null
