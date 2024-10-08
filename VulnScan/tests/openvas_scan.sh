#!/bin/bash

# Define the target system
target="192.168.1.1"  # Replace with your target IP

# Run the OpenVAS vulnerability scan (adjust based on your OpenVAS setup)
omp -h localhost -u admin -w password -T -X "<scan-command>"
