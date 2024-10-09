# Network Security: Demonstrating ARP Poisoning and OS Fingerprinting

This project demonstrates how an ARP Poisoning attack can manipulate network traffic and how Nmap can be used for OS fingerprinting. This was part of a network security assignment.

## Features
- ARP Poisoning demonstration.
- HTTP server setup and manipulation.
- Nmap OS Fingerprinting and analysis.
- Firewall configuration to reroute traffic.

## Prerequisites
- Linux-based environment (Tested on Ubuntu and CORE Network Emulator).
- Basic understanding of networking and ARP tables.
- Wireshark for packet capture.
- Nmap for OS fingerprinting.

## How to Run

1. Clone the repository.
2. Power up the environment using the provided `hw2.xml` file.
3. Run the scripts in the following order:
   ```bash
   # In LegitServer node
   ./start.sh
   
   # In Client node
   ./run_curl.sh
   
   # In Attacker node (for ARP Poisoning)
   ./run_arp_poison.sh
   
   # Set up HTTP server and firewall rules on the attacker node
   ./start_server.sh
   ./config_firewall.sh
   
   # For Nmap scan
   nmap -sV -O -v 10.0.0.4
