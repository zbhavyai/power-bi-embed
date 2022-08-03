#!/bin/bash
# Author: Bhavyai Gupta


# read the vault token
VAULT_TOKEN=$( cat ./vault/vault_token.txt )

# fetch data from vault
username=$( curl -H "X-Vault-Token: ${VAULT_TOKEN}" -X GET http://127.0.0.1:8200/v1/secret/data/creds 2> /dev/null | jq -r '.data.data.email' )
password=$( curl -H "X-Vault-Token: ${VAULT_TOKEN}" -X GET http://127.0.0.1:8200/v1/secret/data/creds 2> /dev/null | jq -r '.data.data.password' )



# additional data for embedding report
client_id=''
group_id=''
report_id=''
scope='openid'
grant_type='password'
resource='https://analysis.windows.net/powerbi/api'



# get the access token using email/password for subsequent requests
ACCESS_TOKEN=$( curl -X POST --data-urlencode "client_id=${client_id}" --data-urlencode "grant_type=${grant_type}" --data-urlencode "resource=${resource}" --data-urlencode "username=${username}" --data-urlencode "password=${password}" --data-urlencode "scope=${scope}" https://login.windows.net/common/oauth2/token 2> /dev/null | jq -r '.access_token' )



# get embed URL for the first (one and only in test setup) report
EMBED_URL=$( curl -X GET -H "Authorization: Bearer ${ACCESS_TOKEN}" https://api.powerbi.com/v1.0/myorg/groups/${group_id}/reports 2> /dev/null | jq -r '.value [0] .embedUrl' )

# escape & to prevent problems with sed (https://stackoverflow.com/a/28589149)
EMBED_URL_MOD=$( echo ${EMBED_URL} | sed 's/&/\\&/g' )



# get the embed token
EMBED_TOKEN=$( curl -X POST -H "Authorization: Bearer ${ACCESS_TOKEN}" -d '{"accessLevel": "View", "allowSaveAs": "false"}' https://api.powerbi.com/v1.0/myorg/groups/${group_id}/reports/${report_id}/GenerateToken 2> /dev/null | jq -r '.token' )



sed "s#EMBED_URL_HERE#${EMBED_URL_MOD}#g" ./src/Config_Template.tmp > ./src/Config.tmp
sed "s#EMBED_TOKEN_HERE#${EMBED_TOKEN}#g" ./src/Config.tmp > ./src/Config.tsx
rm ./src/Config.tmp
