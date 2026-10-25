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
