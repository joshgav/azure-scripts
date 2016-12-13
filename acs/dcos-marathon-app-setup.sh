#! /usr/bin/env bash

SCRIPT_DIR=$(dirname $(realpath ${BASH_SOURCE[0]}))

. ${SCRIPT_DIR}/acs-vars.sh
. ${SCRIPT_DIR}/acs-common.sh

export ACS_MASTER_DNS_NAME=${AZURE_ACS_DNS_PREFIX}mgmt.${AZURE_RG_LOCATION}.cloudapp.azure.com
export MARATHON_APPDEF=${SCRIPT_DIR}/dcos-marathon-docker-node.json

ssh -fNL 8888:localhost:80 -p 2200 azureuser@${ACS_MASTER_DNS_NAME}
dcos config set core.dcos_url http://localhost:8888

dcos package install marathon-lb
dcos marathon app add ${MARATHON_APPDEF}

