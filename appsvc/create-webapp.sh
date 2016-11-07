#!/usr/bin/env sh

. ./azure-webapp-params.sh

azure group create \
    --name $AZURE_RESOURCEGROUP \
    --location $AZURE_LOCATION

azure appserviceplan create \
    --resource-group $AZURE_RESOURCEGROUP \
    --name $AZURE_APPSERVICEPLAN_NAME \
    --location $AZURE_LOCATION \
    --tier 'Basic' \
    --instances 1

azure webapp create \
    --resource-group $AZURE_RESOURCEGROUP \
    --name $AZURE_WEBAPP_NAME \
    --location $AZURE_LOCATION \
    --plan $AZURE_APPSERVICEPLAN_NAME

