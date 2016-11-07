#!/usr/bin/env sh

# DNS: AZURE_DOMAIN_NAME.AZURE_LOCATION.cloudapp.azure.com
# e.g. joshgav-2.westus.cloudapp.azure.com

# set RG_ID
read -p "Resource Group ID: " RG_ID
read -p "Node ID: " NODE_ID

AZURE_HOSTNAME=joshgav-node${NODE_ID}-rg${RG_ID}
AZURE_DOMAIN_NAME=joshgav-${RG_ID}
AZURE_USER=joshgav
# set AZURE_PASSWORD
read -s -p "Password: " AZURE_PASSWORD 

AZURE_LOCATION=westus
AZURE_RESOURCEGROUP=rg-$RG_ID
AZURE_VNET=vnet-$RG_ID
AZURE_SUBNET=subnet-$RG_ID
AZURE_PUBLICIP=public-ip-$RG_ID
AZURE_NSG=nsg-$RG_ID
AZURE_NIC=nic-node${NODE_ID}-rg$RG_ID
AZURE_STORAGE_ACCOUNT=storage4rg$RG_ID

if [ -z "${AZURE_IMAGE_URN+set}" ]; then
  # available versions: `azure vm image list westus credativ Debian 9-DAILY`
  AZURE_IMAGE_URN=credativ:Debian:9-DAILY:9.0.201609260
  # AZURE_IMAGE_URN=Canonical:UbuntuServer:14.04.3-LTS:14.04.201511050
  # AZURE_IMAGE_URN=CoreOS:CoreOS:Stable:766.4.0
fi

echo
echo DNS: ${AZURE_DOMAIN_NAME}.${AZURE_LOCATION}.cloudapp.azure.com

