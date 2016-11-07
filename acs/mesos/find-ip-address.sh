DEFAULT_DEVICE=eth0
IPADDR_RE='/inet\W(([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3})\/[[:digit:]]{1,2}/'
AWK_CMD='{ print $2 }'
ip addr show dev $DEFAULT_DEVICE | \
	awk "$IPADDR_RE $AWK_CMD" | \
	awk -F/ '{ print $1 }'

