#! /usr/bin/env bash

SCRIPT_DIR=$(dirname $(realpath ${BASH_SOURCE[0]}))

. ${SCRIPT_DIR}/acs-vars.sh
. ${SCRIPT_DIR}/acs-common.sh

nonce=$(
  az network lb list --resource-group ${AZURE_RG_NAME} |
    sed -n 's/.*dcos-agent-lb-\([A-Z0-9]*\).*/\1/p'
)

lb_name=dcos-agent-lb-$nonce
backend_pool_name=dcos-agent-pool-$nonce
frontend_ip_name=dcos-agent-lbFrontEnd-$nonce
public_nsg_name=dcos-agent-public-nsg-$nonce

# open <frontend-port> to Internet
# and connect to <backend-port> in <backend-pool>
az network lb rule create \
  --name 'LBRulePort9229' \
  --resource-group ${AZURE_RG_NAME} \
  --backend-pool-name $backend_pool_name \
  --backend-port 10001 \
  --frontend-ip-name $frontend_ip_name \
  --frontend-port 9229 \
  --lb-name $lb_name \
  --protocol tcp \
  --idle-timeout 5

# allow access to dest-port
az network nsg rule create \
  --name 'Allow_10001' \
  --source-address-prefix 'Internet' \
  --source-port-range '*' \
  --destination-address-prefix '*' \
  --destination-port-range '10001' \
  --access Allow \
  --direction Inbound \
  --protocol tcp \
  --nsg-name $public_nsg_name \
  --resource-group ${AZURE_RG_NAME} \
  --priority 1010

