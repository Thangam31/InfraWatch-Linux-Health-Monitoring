#!/bin/bash

# =================================================================
# Project: InfraWatch - Linux Server Health Monitoring System
# Tech: Linux, Bash, Shell Scripting
# =================================================================

LOG_DIR="/var/log/infrawatch"
REPORT_FILE="$LOG_DIR/health_report_$(date +'%Y%m%d_%H%M%S').log"
CPU_THRESHOLD=80
DISK_THRESHOLD=80

# Create Log Directory if not exists
sudo mkdir -p $LOG_DIR
sudo chmod 755 $LOG_DIR

echo "=================================================" | sudo tee -a $REPORT_FILE
echo "       INFRAWATCH SYSTEM HEALTH REPORT           " | sudo tee -a $REPORT_FILE
echo " Date & Time : $(date)"                           | sudo tee -a $REPORT_FILE
echo " Hostname    : $(hostname)"                       | sudo tee -a $REPORT_FILE
echo " Uptime      : $(uptime -p)"                      | sudo tee -a $REPORT_FILE
echo "=================================================" | sudo tee -a $REPORT_FILE
echo "" | sudo tee -a $REPORT_FILE

# 1. CPU Usage Check
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)
CPU_USAGE=$((100 - CPU_IDLE))
echo "[+] CPU Usage: ${CPU_USAGE}%" | sudo tee -a $REPORT_FILE

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "  [ALERT] High CPU Usage Detected: ${CPU_USAGE}%" | sudo tee -a $REPORT_FILE
fi

# 2. Memory Usage Check
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_USAGE=$(( MEM_USED * 100 / MEM_TOTAL ))
echo "[+] Memory Usage: ${MEM_USAGE}% (${MEM_USED}MB / ${MEM_TOTAL}MB)" | sudo tee -a $REPORT_FILE

# 3. Disk Space Check
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "[+] Disk Usage (/): ${DISK_USAGE}%" | sudo tee -a $REPORT_FILE

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "  [ALERT] High Disk Space Usage Detected: ${DISK_USAGE}%" | sudo tee -a $REPORT_FILE
fi

echo "" | sudo tee -a $REPORT_FILE
echo "=================================================" | sudo tee -a $REPORT_FILE
echo "Report generated successfully at $REPORT_FILE"
