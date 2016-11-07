#!/usr/bin/env bash

. ./azure-vm-params.sh

azure group create \
    --name $AZURE_RESOURCEGROUP \
    --location $AZURE_LOCATION

azure network nsg create \
    --resource-group $AZURE_RESOURCEGROUP --name $AZURE_NSG --location $AZURE_LOCATION
azure network nsg rule create \
    --resource-group $AZURE_RESOURCEGROUP --nsg-name $AZURE_NSG --name 'SSH' \
	--protocol tcp --destination-port-range 22 --source-port-range '*' \
	--access allow --direction inbound --priority 102
azure network vnet create \
    --resource-group $AZURE_RESOURCEGROUP --name $AZURE_VNET --location $AZURE_LOCATION --address-prefixes '10.0.0.0/8'
azure network vnet subnet create \
	--resource-group $AZURE_RESOURCEGROUP --vnet-name $AZURE_VNET --name $AZURE_SUBNET --address-prefix '10.0.1.0/24' \
	--network-security-group-name $AZURE_NSG
azure network public-ip create \
	--resource-group $AZURE_RESOURCEGROUP --name $AZURE_PUBLICIP --location $AZURE_LOCATION --domain-name-label $AZURE_DOMAIN_NAME

azure network nic create \
    $AZURE_RESOURCEGROUP $AZURE_NIC $AZURE_LOCATION \
	--network-security-group-name $AZURE_NSG \
	--public-ip-name $AZURE_PUBLICIP \
	--subnet-name $AZURE_SUBNET --subnet-vnet-name $AZURE_VNET

azure storage account create \
    -g $AZURE_RESOURCEGROUP -l $AZURE_LOCATION $AZURE_STORAGE_ACCOUNT \
	--type LRS

azure vm create \
	--resource-group $AZURE_RESOURCEGROUP --name $AZURE_HOSTNAME --location $AZURE_LOCATION --os-type Linux \
	--image-urn $AZURE_IMAGE_URN \
	--admin-username $AZURE_USER --admin-password $AZURE_PASSWORD --ssh-publickey-file ~/.ssh/id_rsa.pub \
	--nic-name $AZURE_NIC \
	--storage-account-name $AZURE_STORAGE_ACCOUNT \
	--vm-size 'Standard_A4'

azure vm show \
    $AZURE_RESOURCEGROUP $AZURE_HOSTNAME $AZURE_LOCATION |
        grep 'Public IP'

echo
echo hostname: ${AZURE_DOMAIN_NAME}.${AZURE_LOCATION}.cloudapp.azure.com

