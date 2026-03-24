# 🚩 Cardinal SOC MOTD 
A professional, modular system-monitoring dashboard (Message of the Day) designed for **Rocky Linux 9** SOC Labs.

## 🦅 The Vision
This dashboard is designed to provide immediate situational awareness the moment you log into your machine. It replaces the generic Linux login screen with a custom Red Cardinal and real-time security data.

## 🚀 Quick Deployment
To install this on your machine, run this single command:

```bash
curl -s https://raw.githubusercontent.com/rvrbetastudent/cardinal-soc-motd/master/motd.sh | sudo tee /opt/cardinal-soc-motd/motd.sh > /dev/null && sudo chmod +x /opt/cardinal-soc-motd/motd.sh && echo "/opt/cardinal-soc-motd/motd.sh" | sudo tee /etc/profile.d/cardinal-soc.sh
```

## 🛠️ Features

* **Authentication Watch:** Live tracking of failed SSH login attempts via `journalctl`.
* **Vulnerability Management:** Checks for pending security updates via `dnf`.
* **Network Status:** Displays Local and Public IP addresses (useful for VPN verification).
* **System Vitals:** Real-time RAM, CPU Load, and Disk utilization.
* **Environmental Awareness:** Integrated weather reporting for Coeur d'Alene.

## 📋 Prerequisites
Most tools are pre-installed on Rocky Linux 9. If `package-cleanup` is missing, install the utilities:
* **yum-utils** (Provides `package-cleanup` for security tracking)
* **curl** (For Weather and Public IP data)

```bash
sudo dnf install yum-utils curl -y
```

⚖️ License

Distributed under the MIT License.
