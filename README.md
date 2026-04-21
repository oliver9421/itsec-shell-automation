# IT Security Automation Scripts

---

## Overview

This repository contains a collection of basic and intermediate security automation scripts written in Bash, PowerShell, and Python.

The project demonstrates how scripting can be used to automate tasks in system administration and IT security, such as log analysis, process monitoring, and user risk evaluation.

---

## Purpose

The purpose of this project is to practice and demonstrate:

- Automation using scripts  
- File-based input handling  
- Conditional logic (if/else)  
- Logging and reporting  
- Data validation and error handling  
- Writing structured and readable code  
- Version control using Git  
- JSON parsing and data correlation  
- Multi-source threat detection  

---

## Scripts

---

### Log Analyzer

Analyzes log files to detect potential security-related events such as failed logins and errors.

**Files:**
- log-analyzer.sh  
- log-analyzer.ps1  
- sample.log  

---

### Security Scan

Performs basic system security checks using Bash.

**Files:**
- security_scan.sh  

---

### Process Checker

Checks whether specific processes are running.

**Files:**
- process-checker.sh  
- process-checker.ps1  
- processlist.txt  

---

### Service Checker

Checks whether Windows services exist and whether they are running or stopped.

**Files:**
- service-checker.ps1  
- servicelist.txt  

---

### User Risk Analysis

Analyzes user data from a CSV file and identifies potential security risks.

**Features:**
- Reads structured data from CSV  
- Evaluates user inactivity  
- Detects risky account states  
- Classifies risk levels (OK, WARNING, MEDIUM, HIGH, CRITICAL)  
- Logs results with timestamps  

**Files:**
- user-risk-analysis.sh  
- user-risk-analysis.ps1  
- users.csv  

---

### Advanced User Risk Analysis

Performs a more advanced risk assessment using multiple factors and scoring logic.

This script introduces validation, scoring, and more realistic security analysis logic.

**Features:**
- Input validation for all required fields  
- Risk scoring system based on multiple conditions  
- Role-based risk (admin accounts)  
- Detection of suspicious login activity  
- MFA (multi-factor authentication) checks  
- Country-based risk evaluation  
- Combination risk detection (e.g. admin without MFA)  
- Error handling for invalid or missing data  
- Outputs sorted results  
- Exports report to CSV  

**Files:**
- advanced-user-risk-analysis.ps1 *(rename your script to this for clarity)*  
- AI_UserSecurityData.csv  
- AI_Risk_Report.csv  

---

### Event Risk Analysis (JSON + CSV)

Analyzes user login activity by combining structured data from a CSV file and a JSON event log.

This script simulates a basic SIEM/SOC detection workflow by correlating multiple data sources and applying rule-based risk classification.

**Features:**
- Parses JSON data (`jq` in Bash, `ConvertFrom-Json` in PowerShell)  
- Filters failed login events  
- Counts failed login attempts per user  
- Combines user status (active/disabled) with event data  
- Applies multi-layer risk classification:
  - **Critical**: Failed login(s) + disabled account  
  - **High**: 3 or more failed logins  
  - **Medium**: At least 1 failed login  
  - **Low**: No failed logins  
- Generates timestamped log reports  

**Files:**
- event-risk-analysis.sh  
- event-risk-analysis.ps1  
- users.csv  
- events.json  
- event_risk_report.log  

---

## Usage

---

### PowerShell

```powershell
.\log-analyzer.ps1
.\process-checker.ps1
.\service-checker.ps1
.\user-risk-analysis.ps1
.\advanced-user-risk-analysis.ps1
.\event-risk-analysis.ps1

## Bash
./log-analyzer.sh
./process-checker.sh
./security_scan.sh
./user-risk-analysis.sh
./event-risk-analysis.sh
