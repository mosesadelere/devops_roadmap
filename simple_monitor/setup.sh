#!/bin/bash

# setup.sh: Install and configure Netdata

# Update the system
echo "Updating system packages..."
sudo apt-get update -y

# Install dependencies
echo "Installing dependencies..."
sudo apt-get install -y curl git

# Install Netdata
echo "Installing Netdata..."
bash <(curl -Ss https://my-netdata.io/kickstart.sh) --non-interactive

# Check if Netdata installation was successful
if [ $? -eq 0 ]; then
    echo "Netdata installed successfully!"
else
    echo "Netdata installation failed. Please check the logs."
    exit 1
fi

# Configure Netdata to monitor basic metrics
echo "Configuring Netdata..."
sudo cp /etc/netdata/netdata.conf /etc/netdata/netdata.conf.bak
sudo sed -i 's/# history = 3996/history = 86400/' /etc/netdata/netdata.conf

# Set up a CPU usage alert
echo "Setting up CPU usage alert..."
sudo tee /etc/netdata/health.d/cpu.conf > /dev/null <<EOL
alarm: high_cpu_usage
on: system.cpu
lookup: average -1m percentage of user,system,softirq,irq
calc: $this
warn: $this > 80
crit: $this > 90
every: 10s
EOL

# Restart Netdata to apply changes
echo "Restarting Netdata..."
sudo systemctl restart netdata

# Display access information
echo "Netdata installation and configuration complete!"
echo "Access the Netdata dashboard at: http://$(hostname -I | awk '{print $1}'):19999"