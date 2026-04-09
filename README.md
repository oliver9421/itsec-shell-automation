IT Security Automation Scripts

This repository contains a set of basic security automation scripts developed in Bash, PowerShell, and Python. The purpose is to demonstrate fundamental scripting techniques used in system administration and IT security.

Purpose

The project focuses on:

automation using scripts
use of loops and functions
handling input from files
logging and error handling
structured and readable code
version control with Git
Included Scripts
Process Checker

Checks whether specified processes are running.

Files:

process-checker.ps1
process-checker.sh
processlist.txt
Service Checker

Checks whether Windows services exist and whether they are running or stopped.

Files:

service-checker.ps1
servicelist.txt
Basic Scripts

Introductory scripts for simple checks and testing.

Files:

basic-security-check.ps1
basic-security-check.sh
hello-bash.sh
hello-ps.ps1
hello-python.py
Features
functions
loops
if/else logic
file-based input
logging
error handling
summary output
Usage
PowerShell

Run:

.\process-checker.ps1
.\service-checker.ps1

If scripts are blocked:

Set-ExecutionPolicy -Scope Process Bypass
Bash

Run:

chmod +x process-checker.sh
./process-checker.sh
Notes
log files are excluded using .gitignore
some Bash checks may not detect Windows processes in Git Bash
Author

Student project in IT security automation.
