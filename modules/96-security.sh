#!/usr/bin/env bash
source "${CONFIG_PATH}"
# Count failed logins from the secure log
failed=$(journalctl _SYSTEMD_UNIT=sshd.service | grep "Failed password" | wc -l)

# If failures > 0, show them in Red (CE), otherwise Green (CO)
if [ "$failed" -gt 0 ]; then
    echo -e "${CE}SSH Failures:${CN}\t${failed} (Check Logs!)"
else
    echo -e "${CO}SSH Failures:${CN}\t0"
fi
