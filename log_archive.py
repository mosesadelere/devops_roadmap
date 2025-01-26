#!/usr/bin/env python3

import os
import sys
import tarfile
from datetime import datetime

# Function to archive logs
def archive_logs(log_directory):
    # Create a timestamp for the archive
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    archive_name = f"logs_archive_{timestamp}.tar.gz"
    archive_dir = "archived_logs"

    # Create the archive directory if it doesn't exist
    if not os.path.exists(archive_dir):
        os.makedirs(archive_dir)

    # Full path for the archive
    archive_path = os.path.join(archive_dir, archive_name)

    # Compress the logs into a tar.gz file
    try:
        with tarfile.open(archive_path, "w:gz") as tar:
            for root, _, files in os.walk(log_directory):
                for file in files:
                    file_path = os.path.join(root, file)
                    tar.add(file_path, arcname=os.path.relpath(file_path, log_directory))
        print(f"Logs archived successfully: {archive_path}")
    except Exception as e:
        print(f"Error archiving logs: {e}")
        sys.exit(1)

    # Log the date and time of the archive
    log_entry = f"Archive created at {datetime.now()} for directory: {log_directory}\n"
    with open("archive_log.txt", "a") as log_file:
        log_file.write(log_entry)

# Main function
def main():
    if len(sys.argv) != 2:
        print("Usage: log-archive <log-directory>")
        sys.exit(1)

    log_directory = sys.argv[1]

    if not os.path.isdir(log_directory):
        print(f"Error: {log_directory} is not a valid directory.")
        sys.exit(1)

    archive_logs(log_directory)

if __name__ == "__main__":
    main()