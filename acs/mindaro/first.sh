#!/usr/bin/env sh

. ./vars.sh

az resource group create \
  --name ${AZURE_ACS_RG_NAME} \
  --location ${AZURE_ACS_LOCATION}

az acs create \
  --resource-group ${AZURE_ACS_RG_NAME} \
  --name ${AZURE_ACS_CLUSTER_NAME} \
  --dns-prefix ${AZURE_ACS_DNS_PREFIX} \
  --ssh-key-value ~/.ssh/id_rsa.pub
  
