#!/bin/bash

# Define variables
GIT_REPO="https://github.com/yourusername/your-repo.git"  # Replace with your Git repository URL
PROJECT_DIR="your-project"                               # Directory where the project will be cloned
DOCKER_IMAGE_NAME="your-app"                             # Name of the Docker image
DB_MIGRATION_SCRIPT="migrate.sh"                         # Path to the database migration script (relative to the project directory)

# Function to display error messages and exit
error_exit() {
    echo "Error: $1"
    exit 1
}

# Step 1: Clone the Git repository
echo "Cloning Git repository..."
if [ -d "$PROJECT_DIR" ]; then
    echo "Project directory already exists. Pulling latest changes..."
    cd "$PROJECT_DIR" || error_exit "Failed to change directory to $PROJECT_DIR"
    git pull || error_exit "Failed to pull latest changes from Git repository"
else
    git clone "$GIT_REPO" "$PROJECT_DIR" || error_exit "Failed to clone Git repository"
    cd "$PROJECT_DIR" || error_exit "Failed to change directory to $PROJECT_DIR"
fi

# Step 2: Build the Docker image
echo "Building Docker image..."
docker build -t "$DOCKER_IMAGE_NAME" . || error_exit "Failed to build Docker image"

# Step 3: Deploy the Docker container
echo "Deploying Docker container..."
docker-compose up -d || error_exit "Failed to start Docker containers"

# Step 4: Run initial database migrations
echo "Running initial database migrations..."
if [ -f "$DB_MIGRATION_SCRIPT" ]; then
    bash "$DB_MIGRATION_SCRIPT" || error_exit "Database migration failed"
else
    error_exit "Database migration script not found at $DB_MIGRATION_SCRIPT"
fi

# Step 5: Verify the application is running
echo "Verifying application status..."
CONTAINER_STATUS=$(docker ps --filter "name=$DOCKER_IMAGE_NAME" --format "{{.Status}}")
if [[ "$CONTAINER_STATUS" == *"Up"* ]]; then
    echo "Application is running successfully!"
else
    error_exit "Application container is not running"
fi

# Final message
echo "Setup completed successfully!"
