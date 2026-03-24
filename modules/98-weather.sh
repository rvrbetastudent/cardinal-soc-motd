#!/usr/bin/env bash
source "${CONFIG_PATH}"

# Fetch weather for Coeur d'Alene (v2 gives a nice compact layout)
# We use 'format=3' for a single line or leave it blank for a small table
weather=$(curl -s "wttr.in/Coeur+d+Alene?format=3&u")

echo -e "${CA}Weather:${CN}\t${weather}"
