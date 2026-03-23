#!/usr/bin/env bash

# 1. Environment & Path Setup
export LANG="en_US.UTF-8"
BASE_DIR=$(dirname "$(readlink -f "$0")")
export BASE_DIR

# Define Colors (Locking in the Red Cardinal)
export CA='\e[31m'
export CN='\e[0m'

# 2. Terminal Geometry Check (Live Detection)
TERM_WIDTH=$(tput cols)
LOGO_WIDTH=45
NIC_WIDTH=50
# We need enough room for both plus a small gap
REQUIRED_WIDTH=$((LOGO_WIDTH + NIC_WIDTH + 10))

# 3. Source the Framework & Config
if [[ -z ${1+x} ]]; then
    export CONFIG_PATH="${BASE_DIR}/config.sh"
else
    export CONFIG_PATH="$1"
fi
source "${BASE_DIR}/framework.sh"

# 4. Collect Module Output (Data Gathering)
output=""
# shellcheck disable=SC2010
modules="$(ls -1 "${BASE_DIR}/modules" | grep -P '^(?<!\d)\d{2}(?!\d)-')"
while read -r module; do
    if ! module_output=$("${BASE_DIR}/modules/${module}" 2> /dev/null); then continue; fi
    output+="${module_output}"
    [[ -n "${module_output}" ]] && output+=$'\n'
done <<< "${modules}"

# 5. Prepare Arrays for side-by-side alignment
mapfile -t nic_lines < "${BASE_DIR}/nic_banner.txt"
mapfile -t stat_lines <<< "$output"
# Combine NIC header and stats into one array for the right column
right_side=("${nic_lines[@]}" "${stat_lines[@]}")

# 6. Final Execution (The Layout Logic)
clear

if [ "$TERM_WIDTH" -ge "$REQUIRED_WIDTH" ]; then
    # --- SIDE-BY-SIDE MODE ---
    # We use dynamic padding based on your ACTUAL window width
    PADDING=$((TERM_WIDTH - NIC_WIDTH - 5))
    
    index=0
    while IFS= read -r logo_line; do
        # %-${PADDING}s forces the Red Cardinal to stay in its lane
        printf "${CA}%-${PADDING}s ${CN}%s\n" "${logo_line}" "${right_side[$index]}"
        ((index++))
    done < "${BASE_DIR}/banner.txt"
else
    # --- STACKED MODE ---
    # Fail-safe: if the window is too narrow, we stack them vertically
    echo -e "${CA}"
    cat "${BASE_DIR}/banner.txt"
    echo -e "${CN}"
    cat "${BASE_DIR}/nic_banner.txt"
    echo -e "${output}"
fi

# Reset everything so your prompt isn't red
echo -e "${CN}"
