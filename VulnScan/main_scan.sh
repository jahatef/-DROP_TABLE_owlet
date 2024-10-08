#!/bin/bash

# Define the list of vulnerability test scripts (without the .sh extension)
vuln_tests=("fuzz_test_afl" "nmap_scan" "nikto_scan" "openvas_scan")

# Define the log directory
log_dir="./logs"
mkdir -p "$log_dir"

# Define the summary file for analysis
summary_file="$log_dir/summary.log"
echo "Vulnerability Scan Summary - $(date)" > "$summary_file"
echo "=========================================" >> "$summary_file"

# Function to run each test script
run_test() {
    local test_name=$1
    local log_file="$log_dir/${test_name}.log"

    echo "Running $test_name..."

    # Call the respective script and redirect its output to a log file
    ./tests/${test_name}.sh > "$log_file"

    echo "Finished $test_name. Results saved in $log_file."
}

# Function to analyze the logs
analyze_logs() {
    local test_name=$1
    local log_file="$log_dir/${test_name}.log"
    local vuln_count=0

    # Basic analysis: Count the number of vulnerabilities (adjust per tool)
    case $test_name in
        nmap_scan)
            vuln_count=$(grep -c "VULNERABLE" "$log_file")
            ;;
        nikto_scan)
            vuln_count=$(grep -c "Vulnerability" "$log_file")
            ;;
        openvas_scan)
            vuln_count=$(grep -c "High" "$log_file")  # Adjust as needed
            ;;
    esac

    echo "$test_name found $vuln_count vulnerabilities." >> "$summary_file"
}

# Loop through each vulnerability test
for test in "${vuln_tests[@]}"; do
    run_test "$test"
    analyze_logs "$test"
done

# Print the summary
echo "=========================================" >> "$summary_file"
echo "Vulnerability scan completed. Summary saved in $summary_file."

# Output the summary to the console
cat "$summary_file"
