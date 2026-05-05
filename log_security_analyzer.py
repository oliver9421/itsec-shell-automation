import logging
from collections import Counter
from datetime import datetime
import re

LOG_FILE = "system.log"
REPORT_FILE = "security_report.txt"
APP_LOG_FILE = "python_analyzer.log"

FAILED_LOGIN_LIMIT = 3

logging.basicConfig(
    filename=APP_LOG_FILE,
    level=logging.INFO,
    format="[%(levelname)s] %(asctime)s - %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S"
)

def read_log_file(file_path):
    try:
        with open(file_path, "r", encoding="utf-8") as file:
            logging.info("Loggfil lästes in korrekt.")
            return file.readlines()
    except FileNotFoundError:
        logging.error(f"Loggfilen hittades inte: {file_path}")
        return []
    except PermissionError:
        logging.error(f"Saknar behörighet att läsa loggfilen: {file_path}")
        return []

def extract_ip_addresses(log_lines):
    ip_pattern = r"\b(?:\d{1,3}\.){3}\d{1,3}\b"
    ip_addresses = []

    for line in log_lines:
        ip_addresses.extend(re.findall(ip_pattern, line))

    return ip_addresses

def analyze_logs(log_lines):
    failed_logins = []
    suspicious_keywords = ["failed", "denied", "unauthorized", "error"]

    for line in log_lines:
        line_lower = line.lower()

        if any(keyword in line_lower for keyword in suspicious_keywords):
            failed_logins.append(line.strip())

    ip_addresses = extract_ip_addresses(failed_logins)
    ip_counter = Counter(ip_addresses)

    risky_ips = {
        ip: count for ip, count in ip_counter.items()
        if count >= FAILED_LOGIN_LIMIT
    }

    return failed_logins, ip_counter, risky_ips

def generate_report(failed_logins, ip_counter, risky_ips):
    with open(REPORT_FILE, "w", encoding="utf-8") as report:
        report.write("=== Säkerhetsrapport från Python-logganalys ===\n")
        report.write(f"Rapport skapad: {datetime.now()}\n\n")

        report.write(f"Antal misstänkta loggrader: {len(failed_logins)}\n")
        report.write(f"Antal unika IP-adresser: {len(ip_counter)}\n\n")

        report.write("IP-adresser och antal träffar:\n")
        for ip, count in ip_counter.items():
            report.write(f"- {ip}: {count} träffar\n")

        report.write("\nRiskklassade IP-adresser:\n")
        if risky_ips:
            for ip, count in risky_ips.items():
                report.write(f"- {ip}: {count} misstänkta händelser\n")
        else:
            report.write("Inga IP-adresser passerade riskgränsen.\n")

        report.write("\nMisstänkta loggrader:\n")
        for entry in failed_logins:
            report.write(entry + "\n")

    logging.info("Säkerhetsrapport skapades korrekt.")

def main():
    logging.info("Startar Python-baserad logganalys.")

    log_lines = read_log_file(LOG_FILE)

    if not log_lines:
        logging.warning("Ingen loggdata analyserades.")
        return

    failed_logins, ip_counter, risky_ips = analyze_logs(log_lines)
    generate_report(failed_logins, ip_counter, risky_ips)

    print(f"Analys klar. Rapport skapad: {REPORT_FILE}")
    logging.info("Logganalys avslutad.")

if __name__ == "__main__":
    main()