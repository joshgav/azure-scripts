#!/usr/bin/env bash

SCRIPT_DIR=$(dirname $(realpath ${BASH_SOURCE[0]}))

. ${SCRIPT_DIR}/acs-vars.sh
. ${SCRIPT_DIR}/acs-common.sh

export AZURE_ACS_GH_URL='https://github.com/joshgav/node-dotnet-ng-docker'
export AZURE_ACR_NAME='joshgav'
export VSTS_ACCOUNT_NAME='joshgav-msft'
export VSTS_PROJECT_NAME='acs-vsts-first'

az acr create \
  --resource-group ${AZURE_RG_NAME} \
  --location ${AZURE_RG_LOCATION} \
  --name ${AZURE_ACR_NAME}

az container release create \
  --target-name ${AZURE_ACS_NAME} \
  --target-resource-group ${AZURE_RG_NAME} \
  --remote-access-token ${GITHUB_TOKEN} \
  --registry-name ${AZURE_ACR_NAME} \
  --remote-url ${AZURE_ACS_GH_URL} \
  --vsts-account-name ${VSTS_ACCOUNT_NAME} \
  --vsts-project-name ${VSTS_PROJECT_NAME}

