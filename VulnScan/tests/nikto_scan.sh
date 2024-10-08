#!/bin/bash

# Define the target system
target="192.168.1.1"  # Replace with your target IP

# Run the Nikto web vulnerability scan
nikto -host "$target"
