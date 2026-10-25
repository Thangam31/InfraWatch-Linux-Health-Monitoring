#!/bin/bash

# =================================================================
# Project 1: InfraWatch - Linux Health Monitoring Engine
# =================================================================

LOG_DIR="/var/log/infrawatch"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/health_$TIMESTAMP.log"

# Ensure Log Directory Exists
mkdir -p "$LOG_DIR"

echo "=====================================================" > "$LOG_FILE"
echo "        INFRAWATCH SYSTEM HEALTH AUDIT REPORT        " >> "$LOG_FILE"
echo "        Timestamp: $(date)                           " >> "$LOG_FILE"
echo "=====================================================" >> "$LOG_FILE"

# 1. CPU Usage (Fixed for Ubuntu comma/decimal formatting)
CPU_IDLE=$(LC_ALL=C top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1 | cut -d',' -f1)
if [ -z "$CPU_IDLE" ]; then
    CPU_USAGE=0
else
    CPU_USAGE=$((100 - CPU_IDLE))
fi
echo "[*] CPU Utilization : $CPU_USAGE%" >> "$LOG_FILE"

# 2. RAM Usage
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_PERCENT=$((MEM_USED * 100 / MEM_TOTAL))
echo "[*] Memory Usage    : ${MEM_PERCENT}% (${MEM_USED}MB / ${MEM_TOTAL}MB)" >> "$LOG_FILE"

# 3. Disk Usage
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "[*] Disk Usage (/)  : ${DISK_USAGE}%" >> "$LOG_FILE"

# Threshold Alerts (80% Alert Trigger)
echo "-----------------------------------------------------" >> "$LOG_FILE"
if [ "$CPU_USAGE" -gt 80 ]; then
    echo "[ALERT] CPU Usage exceeded threshold! Current: $CPU_USAGE%" >> "$LOG_FILE"
fi

if [ "$DISK_USAGE" -gt 80 ]; then
    echo "[ALERT] Disk Usage exceeded threshold! Current: $DISK_USAGE%" >> "$LOG_FILE"
fi

echo "=====================================================" >> "$LOG_FILE"
echo "[+] Health Check Completed Successfully." >> "$LOG_FILE"
