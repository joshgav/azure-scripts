#!/usr/bin/env sh

. ./azure-vm-params.sh

azure network nic create \ 
    $AZURE_RESOURCEGROUP $AZURE_NIC $AZURE_LOCATION \
	--network-security-group-name $AZURE_NSG \
	--subnet-name $AZURE_SUBNET --subnet-vnet-name $AZURE_VNET

azure vm create \
	--resource-group $AZURE_RESOURCEGROUP --name $AZURE_HOSTNAME --location $AZURE_LOCATION --os-type Linux \
	--image-urn $AZURE_IMAGE_URN \
	--admin-username $AZURE_USER --admin-password $AZURE_PASSWORD --ssh-publickey-file ~/.ssh/id_rsa.pub \
	--nic-name $AZURE_NIC \
	--storage-account-name $AZURE_STORAGE_ACCOUNT \
	--vm-size 'Standard_A1'

