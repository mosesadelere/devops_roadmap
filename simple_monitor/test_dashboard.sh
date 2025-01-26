#!/bin/bash

# test_dashboard.sh: Generate system load to test Netdata

echo "Starting system load test..."

# Generate CPU load
echo "Generating CPU load..."
for i in {1..4}; do
    dd if=/dev/zero of=/dev/null &
done

# Generate disk I/O load
echo "Generating disk I/O load..."
dd if=/dev/zero of=testfile bs=1M count=1024

# Generate memory load
echo "Generating memory load..."
stress-ng --vm 2 --vm-bytes 512M --timeout 60s

# Clean up
echo "Cleaning up..."
rm -f testfile
killall dd

echo "System load test complete. Check the Netdata dashboard for metrics."