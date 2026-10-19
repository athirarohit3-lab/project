#!/bin/bash
# Simple server audit script: load, memory, disk

REPORT_DIR="$HOME/project/reports"
mkdir -p "$REPORT_DIR"
REPORT="$REPORT_DIR/audit_$(date +%Y-%m-%d_%H-%M-%S).txt"

{
  echo "===== SERVER AUDIT REPORT ====="
  echo "Date     : $(date)"
  echo "Hostname : $(hostname)"
  echo "IP       : $(hostname -I)"
  echo "Uptime   : $(uptime -p)"
  echo
  echo "----- LOAD AVERAGE (1, 5, 15 min) -----"
  cat /proc/loadavg
  echo "CPU cores: $(nproc)"
  echo
  echo "----- MEMORY USAGE -----"
  free -h
  echo
  echo "----- DISK USAGE -----"
  df -h
  echo
  echo "----- TOP 5 PROCESSES BY MEMORY -----"
  ps aux --sort=-%mem | head -6
  echo
  echo "----- TOP 5 PROCESSES BY CPU -----"
  ps aux --sort=-%cpu | head -6
} > "$REPORT"

echo "Report saved to: $REPORT"
