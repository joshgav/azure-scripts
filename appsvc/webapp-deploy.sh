#!/usr/bin/env sh

# expect these env vars in .env:
# APPINSIGHTS_INSTRUMENTATIONKEY
# GITHUB_TOKEN
set -a
eval $(cat ./.env)
set +a

export AZURE_RG_NAME="rg-appsvc-node3"
export AZURE_RG_LOCATION="westus"
export AZURE_APPSVC_PLAN_NAME="joshgav-appsvc-node3-plan"
export AZURE_APPSVC_WEB_NAME="joshgav-appsvc-node3-web"

export AZURE_NODE_VERSION="NODE|6.9"
export AZURE_NODE_MAIN="bootstrap.js"

export GIT_REPO_URL="https://github.com/joshgav/node-scratch"
export GIT_BRANCH="master"

az group create \
  --name ${AZURE_RG_NAME} \
  --location ${AZURE_RG_LOCATION} \

az appservice plan create \
  --sku S1 \
  --number-of-workers 2 \
  --resource-group ${AZURE_RG_NAME} \
  --name ${AZURE_APPSVC_PLAN_NAME} \
  --location ${AZURE_RG_LOCATION} \
  --is-linux

az appservice web create \
  --resource-group ${AZURE_RG_NAME} \
  --plan ${AZURE_APPSVC_PLAN_NAME} \
  --name ${AZURE_APPSVC_WEB_NAME}

az appservice web config update \
  --resource-group ${AZURE_RG_NAME} \
  --name ${AZURE_APPSVC_WEB_NAME} \
  --linux-fx-version ${AZURE_NODE_VERSION} \
  --startup-file ${AZURE_NODE_MAIN}

az appservice web config appsettings update \
  --resource-group ${AZURE_RG_NAME} \
  --name ${AZURE_APPSVC_WEB_NAME} \
  --settings APPINSIGHTS_INSTRUMENTATIONKEY=$APPINSIGHTS_INSTRUMENTATIONKEY

az appservice web source-control config \
  --resource-group ${AZURE_RG_NAME} \
  --name ${AZURE_APPSVC_WEB_NAME} \
  --repo-url ${GIT_REPO_URL} \
  --branch ${GIT_BRANCH}

