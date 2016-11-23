#!/usr/bin/env sh

. ./vars.sh

az container release create \
  --target-name ${AZURE_ACS_CLUSTER_NAME} \
  --target-resource-group ${AZURE_ACS_RG_NAME} \
  --remote-access-token ${GITHUB_TOKEN} \
  --remote-url ${AZURE_ACS_GH_URL} \
  --vsts-account-name ${VSTS_ACCOUNT_NAME}

