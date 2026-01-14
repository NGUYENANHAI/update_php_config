#!/bin/bash

DNS_PROXY_IP=(
	"103.216.118.10/27"
	"103.166.183.10/27"
	"103.56.163.10/27"
	"2001:df7:ce00:19::3:0000/112"
	"2001:0df7:ce00:16::3:0000/112"
	"2001:0df7:ce00:22::3:0000/112"
)

# Whitelist IP DNS proxy tren CSF
echo 'Whitelist IP DNS proxy on CSF...'

for IP in "${DNS_PROXY_IP[@]}"; do
    csf -a "$IP" "DNS_PROXY" 2>&1
done

# Whitelist IP DNS proxy on cpGuard
echo 'Whitelist IP DNS proxy tren cpGuard...'

for IP in "${DNS_PROXY_IP[@]}"; do
    cpgcli ip --allow "$IP" --reason "DNS_PROXY_IP" 2>&1
done