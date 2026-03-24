#!/usr/bin/env bash
source "${CONFIG_PATH}"
# Check for security updates specifically
updates=$(dnf check-update --security -q | wc -l)

echo -e "${CA}Sec Updates:${CN}\t${updates} pending"
