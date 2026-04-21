#!/bin/bash

logfile="event_risk_report.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$logfile"
}

> "$logfile"
log "Startar analys..."

declare -A status_map
while IFS=',' read -r username status; do
    [[ "$username" == "username" ]] && continue
    status_map["$username"]="$status"
done < users.csv

declare -A fail_count
for user in "${!status_map[@]}"; do
    count=$(jq --arg usr "$user" '[.events[] | select(.user == $usr and .event == "failed_login")] | length' events.json)
    fail_count["$user"]="$count"
done

for user in "${!status_map[@]}"; do
    fails=${fail_count["$user"]}
    stat=${status_map["$user"]}

    if (( fails >= 1 )) && [[ "$stat" == "disabled" ]]; then
        log "$user - CRITICAL RISK (disabled + failed logins)"
    elif (( fails >= 3 )); then
        log "$user - HIGH RISK (3+ failed attempts)"
    elif (( fails >= 1 )); then
        log "$user - MEDIUM RISK (failed attempts)"
    else
        log "$user - LOW RISK"
    fi
done

log "Analys slutförd."