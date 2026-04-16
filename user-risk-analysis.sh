#!/bin/bash

logfile="user_risk_report.log"

log() {
echo "$(date) - $1" | tee -a $logfile
}

while IFS=',' read -r username days status; do
status=$(echo "$status" | tr -d '\r')

[[ "$username" == "username" ]] && continue

if [[ "$days" -gt 180 ]]; then
    if [[ "$status" == "disabled" ]]; then
        log "$username – KRITISK RISK (inaktiv > 180 dagar & disabled)"
    else
        log "$username – HIGH RISK (inaktiv > 180 dagar)"
    fi
elif [[ "$days" -gt 90 ]]; then
    log "$username – MEDIUM RISK (inaktiv > 90 dagar)"
elif [[ "$status" == "disabled" ]]; then
    log "$username – WARNING (disabled men nyligen inloggad)"
else
    log "$username – OK"
fi
done < users.csv

log "Analys slutförd."