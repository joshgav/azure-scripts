# Usage: $0 name protocol dstport priority

. `dirname $0`/azure-vm-params.sh

RULE_NAME=$1
RULE_PROTOCOL=$2
RULE_DSTPORT=$3
RULE_PRIORITY=$4

azure network nsg rule create --resource-group $AZURE_RESOURCEGROUP --nsg-name $AZURE_NSG --name $RULE_NAME \
	--protocol $RULE_PROTOCOL --destination-port-range $RULE_DSTPORT --source-port-range '*' \
	--access allow --direction inbound --priority $RULE_PRIORITY

