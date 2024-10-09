# ARP Poisoning and OS Fingerprinting Project Documentation

## Introduction
This document provides an in-depth explanation of the project setup and the processes involved in executing an ARP poisoning attack and using Nmap for OS fingerprinting. The project simulates a network with three nodes: **LegitServer**, **Client**, and **Attacker**. The goal of this project is to demonstrate the effects of ARP poisoning in manipulating network traffic and to illustrate how Nmap can be used for network reconnaissance.

---

## 1. Project Setup

### 1.1 Tools and Environment
- **CORE Network Emulator**: Used to simulate network nodes.
- **Ubuntu-based Linux**: Operating system for the network nodes.
- **Wireshark**: To monitor and capture network packets during the attack.
- **Nmap**: Used to fingerprint the OS of the server.

### 1.2 Nodes Description
- **LegitServer**: Acts as the victim server that will be accessed by the client.
- **Client**: A node that requests HTTP resources from LegitServer.
- **Attacker**: A malicious node that performs ARP poisoning to intercept traffic between the Client and LegitServer.

### 1.3 Configuration File
The environment is pre-configured using the `hw2.xml` file provided in the repository. This file defines the network layout and the nodes.

### 1.4 ARP Poisoning Workflow
1. LegitServer hosts an HTTP server that the Client accesses.
2. The Attacker performs ARP poisoning, redirecting traffic meant for LegitServer to its own malicious server.
3. The Attacker modifies the Client’s ARP table, mapping the LegitServer’s IP to the Attacker’s MAC address.
4. The Attacker serves different content to the Client, effectively becoming a man-in-the-middle (MITM).

---

## 2. Steps to Run the Project

### 2.1 LegitServer Node Setup
1. **Start the HTTP server**:
   - Run the `start.sh` script:
     ```bash
     ./start.sh
     ```
   - This will start an HTTP server on port `8000`, ready to serve content to clients.

### 2.2 Client Node Setup
1. **Request resources from LegitServer**:
   - The Client node sends an HTTP request to the LegitServer using the `run_curl.sh` script:
     ```bash
     ./run_curl.sh
     ```
   - This script makes an HTTP request and retrieves content from the server.

2. **View ARP Table**:
   - To see the ARP table mapping of the Client node:
     ```bash
     arp -na
     ```
   - This will display the MAC address of LegitServer, ensuring normal communication is in place before the attack.

### 2.3 Attacker Node - ARP Poisoning
1. **Run ARP Poisoning Attack**:
   - The attacker uses the `run_arp_poison.sh` script to perform the ARP poisoning:
     ```bash
     ./run_arp_poison.sh
     ```
   - This script floods the Client’s ARP table with forged packets, mapping LegitServer’s IP to the Attacker’s MAC address.

2. **Verify ARP Table Modification**:
   - After running the attack, the Client’s ARP table should now map the LegitServer’s IP to the Attacker’s MAC address. Run the following on the Client node to verify:
     ```bash
     arp -na
     ```
   - The output should show the attacker’s MAC address instead of the LegitServer’s.

### 2.4 Attacker Node - HTTP Server Setup
1. **Run HTTP Server on Attacker Node**:
   - The Attacker starts their own HTTP server to serve malicious content to the Client:
     ```bash
     ./start_server.sh
     ```
   - The server listens on port `8000`.

2. **Configure Firewall**:
   - To ensure that all Client traffic is intercepted and forwarded to the Attacker’s server, the firewall rules are set using:
     ```bash
     ./config_firewall.sh
     ```

### 2.5 Wireshark Capture
   - During the ARP poisoning attack, run **Wireshark** on the Attacker node to capture and inspect ARP packets.
   - Look for **ARP Request** and **ARP Reply** packets showing how the attacker spoofs the LegitServer’s IP address.

---

## 3. Nmap Scanning

### 3.1 OS Fingerprinting
   - After performing the ARP poisoning attack, the Attacker runs an **Nmap** OS fingerprinting scan against LegitServer:
     ```bash
     nmap -sV -O -v 10.0.0.4
     ```
   - This command scans the server to identify open ports and attempts to determine the operating system.

### 3.2 Nmap Results Interpretation
   - The OS scan may fail if the server’s responses are unclear, but Nmap can provide other useful details, such as open ports and services.
   - In the project’s case, the scan revealed:
     - Open port: `8000/tcp`
     - Service: `SimpleHTTPServer 0.6`

### 3.3 Uptime Information
   - Nmap can also guess the uptime of the server:
     ```
     Uptime: 13.350 days
     ```
   - This information can be valuable to an attacker, indicating the server's maintenance schedule or any potential vulnerabilities related to older versions.

---

## 4. Conclusion

This project demonstrates how ARP poisoning can allow an attacker to manipulate network traffic, intercept sensitive information, and serve fake content to a victim. It also illustrates the importance of monitoring ARP tables and using tools like Nmap for network reconnaissance. Key takeaways include:

- ARP poisoning can be used to hijack network communications.
- Properly configured firewalls and network monitoring tools like Wireshark can help detect and prevent such attacks.
- OS fingerprinting with Nmap can give attackers useful insights into server vulnerabilities, but it’s not always conclusive.

---

## 5. Detailed Documentation
For a more detailed explanation and step-by-step guide, please refer to the complete assignment documentation [here][ https://github.com/AllenJustine/Network-Security-ARP-Poisoning/blob/149a541a8288b6a75331892c40635120f3a2800d/ARP%20Poisoning%20and%20OS%20Fingerprinting%20Project%20Documentation.pdf].

---

## 6. References
- [ARP Poisoning - Wikipedia](https://en.wikipedia.org/wiki/ARP_spoofing)
- [Nmap Official Documentation](https://nmap.org/book/man.html)
- [Wireshark User Guide](https://www.wireshark.org/docs/wsug_html_chunked/)
