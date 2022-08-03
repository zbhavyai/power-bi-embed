#!/bin/bash
# Author: Bhavyai Gupta


# clean old data (only for testing envs)
rm -rf vault-data

# start the vault server
vault server -config=custom_config.hcl
