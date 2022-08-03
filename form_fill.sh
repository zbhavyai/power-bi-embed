#!/bin/bash
# Author: Bhavyai Gupta


# read the vault token
VAULT_TOKEN=$( cat ./vault/vault_token.txt )

# user fills forms with login credentials to power bi
# the password is saved/updated in vault
curl -H "X-Vault-Token: $VAULT_TOKEN" -X POST -d '{ "data": {"email": "<email>", "password": "<password>"} }' http://127.0.0.1:8200/v1/secret/data/creds &> /dev/null
