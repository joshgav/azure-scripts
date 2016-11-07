#!/usr/bin/env sh

read -p "Resource Group ID: " RG_ID

AZURE_LOCATION=westus
AZURE_RESOURCEGROUP=rg-${RG_ID}
AZURE_APPSERVICEPLAN_NAME=appplan-${RG_ID}
AZURE_WEBAPP_NAME=webapp-${RG_ID}

