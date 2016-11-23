#!/usr/bin/env sh

export AZURE_RG_NAME="rg-tuxedo-node"
export AZURE_RG_DEPLOYMENT_NAME="rg-tuxedo-node-01"

azure group create \
    --name ${AZURE_RG_NAME} \
    --location westus \
    --deployment-name ${AZURE_RG_DEPLOYMENT_NAME} \
    --template-file "./tuxedo_node.json" \
    --parameters-file "./tuxedo_node.params.json"

# azure webapp config set $AZURE_RG_NAME 'joshgav-tuxedo-node-app-01' --nodeversion 6.6.0

# azure group deployment operation list $AZURE_RG_NAME $AZURE_RG_DEPLOYMENT_NAME

