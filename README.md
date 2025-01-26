# devops_roadmap
Explanation of the server-stats.sh script

    OS Version: Fetches the OS version from /etc/os-release.

    Uptime: Displays the server's uptime using the uptime command.

    Load Average: Displays the load average for the last 1, 5, and 15 minutes.

    Logged-in Users: Lists currently logged-in users using the who command.

    Failed Login Attempts: Shows the last 10 failed login attempts using lastb.

    Total CPU Usage: Calculates CPU usage using the top command.

    Total Memory Usage: Displays memory usage (used vs total) and the percentage.

    Total Disk Usage: Shows disk usage for the root filesystem (/).

    Top 5 Processes by CPU Usage: Lists the top 5 processes consuming the most CPU.

    Top 5 Processes by Memory Usage: Lists the top 5 processes consuming the most memory.


** OS Version **
"Ubuntu 20.04.3 LTS"

** Uptime **
up 2 days, 4 hours, 12 minutes

** Load Average **
  0.35, 0.40, 0.41

** Logged-In Users **
user1    pts/0        2025-01-26 08:00 (192.168.1.10)

** Failed Login Attempts **
btmp begins Sun Jan 26 08:00:01 2025

** Total CPU Usage **
User: 2.5%, System: 1.2%, Idle: 96.3%

** Memory Usage **
Used: 4.2Gi / Total: 8.0Gi (52.5%)

** Disk Usage **
Used: 50G, Available: 450G, Total: 500G, Usage: 10%

** Top 5 Processes by CPU Usage **
  PID COMMAND        %CPU
  1234 python3       23.5
  4321 java          15.0
  6789 nginx         10.2
  9876 postgres       5.6
  2345 apache2        3.1

** Top 5 Processes by Memory Usage **
  PID COMMAND        %MEM
  1234 python3       12.3
  4321 java           8.5
  6789 nginx          5.2
  9876 postgres       4.1
  2345 apache2        2.8
