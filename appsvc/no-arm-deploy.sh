#!/usr/bin/env sh

export AZURE_RG_NAME="rg-tuxedo-node"
export AZURE_RG_LOCATION="westus"
export AZURE_APPSVC_PLAN_NAME="joshgav-tuxedo-node-farm"
export AZURE_APPSVC_WEB_NAME="joshgav-tuxedo-node-web"

export AZURE_NODE_VERSION="6.6.0"
export AZURE_NODE_MAIN="server.js"

export GIT_REPO_URL="https://github.com/joshgav/node-scratch"
export GIT_BRANCH="az-appsvc"

az resource group create \
    --name ${AZURE_RG_NAME} \
    --location ${AZURE_RG_LOCATION} \

az appservice plan create \
    --sku S1 \
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
    --node-version ${AZURE_NODE_VERSION} \
    --startup-file ${AZURE_NODE_MAIN}

az appservice web source-control config \
    --resource-group ${AZURE_RG_NAME} \
    --name ${AZURE_APPSVC_WEB_NAME} \
    --repo-url ${GIT_REPO_URL} \
    --branch ${GIT_BRANCH}

az appservice web source-control sync \
    --resource-group ${AZURE_RG_NAME} \
    --name ${AZURE_APPSVC_WEB_NAME}

