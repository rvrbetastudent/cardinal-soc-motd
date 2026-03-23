#!/usr/bin/env bash
source "${CONFIG_PATH}"

# Get Public IP
public_ip=$(curl -s https://ifconfig.me)
# Get Local IP
local_ip=$(hostname -I | awk '{print $1}')

echo -e "${CA}Local IP:${CN}\t${local_ip}"
echo -e "${CA}Public IP:${CN}\t${public_ip}"
