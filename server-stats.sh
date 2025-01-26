#!/bin/bash

# Function to display the server stats
display_stats() {
    echo "========================================="
    echo "          Server Performance Stats       "
    echo "========================================="

    # OS Version
    echo -e "\n**OS Version**"
    cat /etc/os-release | grep "PRETTY_NAME" | cut -d '"' -f 2

    # Uptime
    echo -e "\n**Uptime**"
    uptime -p

    # Load Average
    echo -e "\n**Load Average**"
    cat /proc/loadavg | awk '{print "1 min: "$1", 5 min: "$2", 15 min: "$3}'

    # Logged-in Users
    echo -e "\n**Logged-in Users**"
    who

    # Failed Login Attempts
    echo -e "\n**Failed Login Attempts**"
    sudo lastb | head -n 10

    # Total CPU Usage
    echo -e "\n**Total CPU Usage**"
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "CPU Usage: " 100 - $1"%"}'

    # Total Memory Usage
    echo -e "\n**Total Memory Usage**"
    free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'

    # Total Disk Usage
    echo -e "\n**Total Disk Usage**"
    df -h / | awk 'NR==2{printf "Disk Usage: %s/%s (%s)\n", $3,$2,$5}'

    # Top 5 Processes by CPU Usage
    echo -e "\n**Top 5 Processes by CPU Usage**"
    ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 6

    # Top 5 Processes by Memory Usage
    echo -e "\n**Top 5 Processes by Memory Usage**"
    ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%mem | head -n 6

    echo "========================================="
}

# Run the function
display_stats