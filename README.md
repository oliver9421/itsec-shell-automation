# IT Security Automation Scripts

This repository contains a collection of basic security automation scripts written in Bash, PowerShell, and Python. The project demonstrates fundamental scripting techniques used in system administration and IT security.

---

## Purpose

The goal of this project is to practice and demonstrate:

- Automation using scripts
- Use of loops and functions
- File-based input handling
- Logging and error detection
- Structured and readable code
- Version control using Git

---

## Included Scripts

### Log Analyzer
Analyzes a log file and detects potential security-related events.

Features:
- Detects failed login attempts
- Identifies error messages
- Flags unauthorized access attempts
- Generates a summary report
- Logs results to a file

Files:
- `log-analyzer.sh`
- `log-analyzer.ps1`
- `sample.log`

---

### Security Scan
Performs basic system security checks using Bash.

Features:
- Runs automated checks on the system
- Helps identify potential security issues
- Demonstrates basic security scripting

Files:
- `security_scan.sh`

---

### Process Checker
Checks whether specified processes are running.

Files:
- `process-checker.sh`
- `process-checker.ps1`
- `processlist.txt`

---

### Service Checker
Checks whether Windows services exist and if they are running or stopped.

Files:
- `service-checker.ps1`
- `servicelist.txt`

---

### Basic Scripts
Simple scripts for testing and learning purposes.

Files:
- `basic-security-check.sh`
- `basic-security-check.ps1`
- `hello-bash.sh`
- `hello-ps.ps1`
- `hello-python.py`

---

## Features

- Functions and modular code
- Looping through data
- Conditional logic (if/else)
- File input handling
- Logging and reporting
- Summary output generation

---

## Usage

### PowerShell

Run scripts:

```powershell
.\log-analyzer.ps1
.\process-checker.ps1
.\service-checker.ps1
