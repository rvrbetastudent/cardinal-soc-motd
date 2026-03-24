# 🚩 Cardinal SOC MOTD 
A professional, modular system-monitoring dashboard (Message of the Day) designed for **Rocky Linux 9** SOC Labs.

## 🦅 The Vision
This dashboard is designed to provide immediate situational awareness the moment you log into your machine. It replaces the generic Linux login screen with a custom Red Cardinal and real-time security data.

## 🚀 Quick Deployment
To install this on your machine, run this single command:

```bash
git clone https://github.com/rvrbetastudent/cardinal-soc-motd.git && cd cardinal-soc-motd && chmod +x motd.sh modules/*.sh && ./motd.sh
```

## 🛠️ Features

* **Authentication Watch:** Live tracking of failed SSH login attempts via `journalctl`.
* **Vulnerability Management:** Checks for pending security updates via `dnf`.
* **Network Status:** Displays Local and Public IP addresses (useful for VPN verification).
* **System Vitals:** Real-time RAM, CPU Load, and Disk utilization.
* **Environmental Awareness:** Integrated weather reporting for Coeur d'Alene.

## 📋 Prerequisites

Ensure your system has the following tools installed:

* **git**
* **curl** (Required for Weather and Public IP modules)
* **procps-ng** (Required for system stats)
⚖️ License

Distributed under the MIT License.
