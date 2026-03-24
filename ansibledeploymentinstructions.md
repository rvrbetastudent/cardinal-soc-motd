# 🦅 Cardinal SOC MOTD: Deployment Guide
**Target Environment:** Rocky Linux 9 SOC Lab  
**Method:** Ansible Ad-Hoc (Direct Execution)

---

### **Step 1: Prepare the Inventory (The Map)**
Ansible needs to know which machines belong to the `soc_nodes` group. The administrator must ensure the hosts are defined in the inventory file.

1.  **Open the inventory file:**
    ```bash
    sudo nano /etc/ansible/hosts
    ```
2.  **Add the SOC IP range:**
    ```ini
    [soc_nodes]
    10.0.16.[209:221]
    ```
    > **Note:** Using `[209:221]` is the shorthand way to tell Ansible to target every IP from .209 to .221 inclusive.

---

### **Step 2: Test Connectivity**
Verify that the Control Node can communicate with all managed nodes before pushing the payload.

* **Run the Ping Test:**
    ```bash
    ansible soc_nodes -m ping
    ```
* **Success Criteria:** Every IP should return a green `"pong"`. If any return "UNREACHABLE," check SSH connectivity or credentials.

---

### **Step 3: Execute the "Master Command"**
Once the connection is verified, run the deployment one-liner. This command creates the directory, sets user ownership, downloads the script, and enables the login trigger.

* **The Command:**
    ```bash
    ansible soc_nodes -m shell -a 'sudo mkdir -p /opt/cardinal-soc-motd && sudo chown -R $USER:$USER /opt/cardinal-soc-motd && curl -s [https://raw.githubusercontent.com/rvrbetastudent/cardinal-soc-motd/master/motd.sh](https://raw.githubusercontent.com/rvrbetastudent/cardinal-soc-motd/master/motd.sh) | tee /opt/cardinal-soc-motd/motd.sh > /dev/null && chmod +x /opt/cardinal-soc-motd/motd.sh && echo "/opt/cardinal-soc-motd/motd.sh" | sudo tee /etc/profile.d/cardinal-soc.sh' --ask-become-pass
    ```
* **The Prompt:** The terminal will ask for the **BECOME password**. The administrator must enter the `sudo` password for the lab machines.

---

### **Step 4: Verification (The Audit)**
As a rule of thumb in forensics: **Trust, but verify.**

1.  **Visual Confirmation:** Log into any machine in the range (e.g., `10.0.16.210`). The Red Cardinal and system stats should appear immediately.
2.  **Manual Ownership Check:**
    ```bash
    ls -l /opt/cardinal-soc-motd/
    ```
    *Check that the files are owned by the local user and not root.*

---

### **🛠️ Troubleshooting for the Admin**

| Issue | Solution |
| :--- | :--- |
| **Authentication Failed** | Add the `-k` flag to the command to prompt for the SSH password. |
| **Missing Dependencies** | Run: `ansible soc_nodes -m dnf -a "name=curl,yum-utils state=present" --become --ask-become-pass` |
| **Permission Denied** | Ensure the user running the command has `sudo` privileges on the target nodes. |
