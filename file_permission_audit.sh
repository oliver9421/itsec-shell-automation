#!/bin/bash

# Säkerhetsgranskning av filrättigheter
# Kontrollerar osäkra rättigheter i Linux-miljö

set -o pipefail

LOGFILE="./file_permission_audit.log"
SEARCH_PATH="/etc"

log_info() {
    echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}

log_warning() {
    echo "[WARNING] $(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}

log_error() {
    echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}

check_path() {
    if [ ! -d "$SEARCH_PATH" ]; then
        log_error "Sökvägen finns inte: $SEARCH_PATH"
        exit 1
    fi
}

check_777_files() {
    log_info "Kontrollerar filer med 777-rättigheter..."
    find "$SEARCH_PATH" -type f -perm 0777 2>/dev/null | tee -a "$LOGFILE"
}

check_world_writable() {
    log_info "Kontrollerar world-writable filer..."
    find "$SEARCH_PATH" -type f -perm -0002 2>/dev/null | tee -a "$LOGFILE"
}

check_suid_sgid() {
    log_info "Kontrollerar SUID/SGID-filer..."
    find "$SEARCH_PATH" -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null | tee -a "$LOGFILE"
}

check_no_owner() {
    log_info "Kontrollerar filer utan ägare..."
    find "$SEARCH_PATH" \( -nouser -o -nogroup \) 2>/dev/null | tee -a "$LOGFILE"
}

main() {
    log_info "Startar säkerhetsgranskning av filrättigheter"
    log_info "Sökväg: $SEARCH_PATH"

    check_path
    check_777_files
    check_world_writable
    check_suid_sgid
    check_no_owner

    log_info "Säkerhetsgranskning avslutad"
    log_info "Resultat sparat i: $LOGFILE"
}

main