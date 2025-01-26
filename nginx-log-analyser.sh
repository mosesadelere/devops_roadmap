#!/bin/bash

# Check if the log file is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log-file>"
    exit 1
fi

LOG_FILE=$1

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file $LOG_FILE not found."
    exit 1
fi

# Function to display a section header
section_header() {
    echo "========================================="
    echo "$1"
    echo "========================================="
}

# Top 5 IP addresses with the most requests
section_header "Top 5 IP Addresses"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5

# Top 5 most requested paths
section_header "Top 5 Requested Paths"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5

# Top 5 response status codes
section_header "Top 5 Response Status Codes"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5

# Top 5 user agents
section_header "Top 5 User Agents"
awk -F'"' '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5