#!/bin/bash

# Redirect all non-HTTP output to a log file
LOG_FILE="/var/log/deploy.log"

# Write HTTP header for Apache to understand
echo "Content-type: text/plain"
echo ""

# Begin logging
{
    echo "Starting deploy script at $(date)"

    # Resolve the directory of the script, even if it's a symlink
    SOURCE=${BASH_SOURCE[0]}
    while [ -L "$SOURCE" ]; do
        DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
        SOURCE=$(readlink "$SOURCE")
        [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE
    done
    REPO_DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
    DEPLOY_DIR="/var/www/html/punschabend"

    # Change to the repo directory and pull latest changes
    cd "$REPO_DIR"
    echo "Pulling latest changes from the main branch..."
    git pull origin main >> "$LOG_FILE" 2>&1

    # Sync only the /web directory contents to the /var/www/html
    echo "Syncing files to deployment directory..."
    rsync -av --delete "$REPO_DIR/web/" "$DEPLOY_DIR/" >> "$LOG_FILE" 2>&1

    echo "Deployment completed successfully."
} >> "$LOG_FILE" 2>&1

# Output a success message for HTTP response
echo "Deployment completed successfully."

