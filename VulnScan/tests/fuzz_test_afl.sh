#!/bin/bash

# Path to the target binary (compiled with AFL++)
target_binary="./target_binary"  # Replace with the actual path to your binary
input_dir="./input_dir"           # Input directory containing initial seed files
output_dir="./output_dir"         # Output directory for AFL++
fuzz_log="./logs/afl_fuzz.log"    # Log file for fuzz testing

# Check if AFL++ is installed
if ! command -v afl-fuzz &> /dev/null; then
    echo "AFL++ is not installed or not in PATH."
    exit 1
fi

# Create directories if they don't exist
mkdir -p "$input_dir" "$output_dir"

# Add seed inputs if input directory is empty
if [ -z "$(ls -A "$input_dir")" ]; then
    echo "Adding default seed files to $input_dir"
    echo "sample_input" > "$input_dir/seed.txt"  # Add a basic input as seed
fi

# Run AFL++ fuzzer on the target binary
echo "Starting AFL++ fuzz testing on $target_binary..."
afl-fuzz -i "$input_dir" -o "$output_dir" -- "$target_binary" @@

# Redirecting the output to the log file
echo "AFL++ fuzzing completed. Check $fuzz_log for results."
