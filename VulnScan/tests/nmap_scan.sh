#!/bin/bash

# Define the target system
target="192.168.1.1"  # Replace with your target IP

# Run the Nmap vulnerability scan
nmap -sV --script vuln "$target"
