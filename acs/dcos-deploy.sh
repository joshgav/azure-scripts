#!/usr/bin/env bash

export AZURE_ACS_ORCHESTRATOR_TYPE="DCOS"

SCRIPT_DIR=$(dirname $(realpath ${BASH_SOURCE[0]}))

. ${SCRIPT_DIR}/acs-vars.sh
. ${SCRIPT_DIR}/acs-common.sh

info "SCRIPT_DIR set to $SCRIPT_DIR"

rg_exists=$(az group exists --name ${AZURE_RG_NAME})

if test -z $rg_exists; then 
  az group create \
    --name ${AZURE_RG_NAME} \
    --location ${AZURE_RG_LOCATION};
fi

az acs create \
  --name ${AZURE_ACS_NAME} \
  --resource-group ${AZURE_RG_NAME} \
  --dns-prefix ${AZURE_ACS_DNS_PREFIX} \
  --location ${AZURE_RG_LOCATION} \
  --orchestrator-type ${AZURE_ACS_ORCHESTRATOR_TYPE} \
  --ssh-key-value ${AZURE_SSH_KEY_PATH}
  
${SCRIPT_DIR}/dcos-marathon-app-setup.sh
${SCRIPT_DIR}/dcos-open-port.sh

