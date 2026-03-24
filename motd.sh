#!/usr/bin/env bash

# 1. Setup & Paths
export LANG="en_US.UTF-8"
BASE_DIR="/opt/cardinal-soc-motd"
CA='\e[31m'
CN='\e[0m'
REQUIRED_WIDTH=100

# 2. Collect Data (The Silent, Single-Line Method)
# This removes all "stray zeros" by forcing one-line integers
sec_count=$(package-cleanup --security -q 2>/dev/null | grep -c "Needed" | tail -n 1 | xargs)
ssh_fails=$(journalctl _SYSTEMD_UNIT=sshd.service --since "24 hours ago" 2>/dev/null | grep -c "Failed password" | tail -n 1 | xargs)
local_ip=$(hostname -I | awk '{print $1}' | xargs)
public_ip=$(curl -s ifconfig.me | xargs)
# '&u' forces Fahrenheit
weather=$(curl -s "wttr.in/Coeur%20d%20Alene?format=1&u" | tr -d '\n\r')

# 3. Build the Stats Array
output="Updates Pending:  ${sec_count:-0}"
output+=$'\n'"SSH Failures:     ${ssh_fails:-0}"
output+=$'\n'"Local IP:         ${local_ip}"
output+=$'\n'"Public IP:        ${public_ip}"
output+=$'\n'"Weather:          ${weather}"

# 4. Prepare Arrays
if [[ -f "${BASE_DIR}/banner.txt" ]]; then
    mapfile -t logo_lines < "${BASE_DIR}/banner.txt"
else
    logo_lines=(" [ BIRD FILE MISSING ] ")
fi

if [[ -f "${BASE_DIR}/nic_banner.txt" ]]; then
    mapfile -t nic_lines < "${BASE_DIR}/nic_banner.txt"
else
    nic_lines=(" [ NIC FILE MISSING ] ")
fi

mapfile -t stat_lines <<< "$output"
right_side=("${nic_lines[@]}" "" "${stat_lines[@]}")

# 5. Final Execution (The Teleport Method)
clear
TERM_WIDTH=$(tput cols)
max_l=${#logo_lines[@]}
[[ ${#right_side[@]} -gt $max_l ]] && max_l=${#right_side[@]}

if [ "$TERM_WIDTH" -ge "$REQUIRED_WIDTH" ]; then
    for (( i=0; i<max_l; i++ )); do
        bird=$(echo "${logo_lines[$i]}" | tr -d '\r')
        info=$(echo "${right_side[$i]}" | tr -d '\r')

        # \033[60G teleports the stats to Column 60, keeping them perfectly straight.
        echo -ne "${CA}${bird}${CN}"
        echo -e "\033[60G${info}"
    done
else
    # Stacked Mode for small windows
    echo -e "${CA}"
    printf "%s\n" "${logo_lines[@]}"
    echo -e "${CN}"
    printf "%s\n" "${right_side[@]}"
fi
echo -e "${CN}"
