#!/usr/bin/env sh

export AZURE_RG_NAME="rg-container-node1"
export AZURE_RG_LOCATION="westus"
export AZURE_APPSVC_PLAN_NAME="joshgav-container-node1-farm"
export AZURE_APPSVC_WEB_NAME="joshgav-container-node1-web"

# best practice would be to automatically build and push
# an updated image, and sync the tag/ver# in the build and here.
export DOCKER_HUB_IMAGE_NAME="joshgav/node-scratch:latest"

az group create \
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

az appservice web config container update \
  --resource-group ${AZURE_RG_NAME} \
  --name ${AZURE_APPSVC_WEB_NAME} \
  --docker-custom-image-name ${DOCKER_HUB_IMAGE_NAME}

