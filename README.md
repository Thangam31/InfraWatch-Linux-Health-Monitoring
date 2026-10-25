# 🛡️ InfraWatch — Linux Server Health Monitoring System

An automated shell-based Linux system health monitoring and log reporting utility designed for production EC2 instances and Linux servers.

## 🌟 Key Features
* **Automated Metrics Collection:** Tracks CPU utilization, RAM usage, and Disk space partition thresholds.
* **Alert System:** Generates warning flags when CPU or Disk usage exceeds predefined thresholds (80%).
* **Scheduled Operations:** Integrated with Linux `crontab` daemon for automated background execution.
* **Audit Logging:** Automatically outputs timestamped audit reports to `/var/log/infrawatch/`.

## 🛠️ Tech Stack
* **OS:** Linux (Ubuntu / Amazon Linux)
* **Scripting:** Bash / Shell Scripting
* **System Utilities:** `top`, `free`, `df`, `cron`, `awk`, `grep`

## 🚀 Quick Start
1. Grant execution permissions:
   ```bash
   chmod +x infrawatch.sh
   ```
2. Run the monitor:
   ```bash
   sudo ./infrawatch.sh
   ```

## 📊 Sample Audit Log Output
When executed manually or via `cron`, InfraWatch generates structured health reports inside `/var/log/infrawatch/`:

```text
=====================================================
        INFRAWATCH SYSTEM HEALTH AUDIT REPORT        
        Timestamp: Sun Oct 25 09:33:59 UTC 2026                           
=====================================================
[*] CPU Utilization : 5%
[*] Memory Usage    : 35% (318MB / 908MB)
[*] Disk Usage (/)  : 35%
-----------------------------------------------------
=====================================================
[+] Health Check Completed Successfully.
```

## ⏰ Cron Automation Setup
To run InfraWatch automatically every 5 minutes:
```bash
(crontab -l 2>/dev/null; echo "*/5 * * * * /home/ubuntu/infrawatch/infrawatch.sh") | crontab -
```
