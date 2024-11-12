#!/usr/bin/env bash

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
REPO_DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
DEPLOY_DIR="/var/www/html/punschabend"

# Change to the repo directory and pull latest changes
cd $REPO_DIR
git pull origin main

# Sync only the /web directory contents to the /var/www/html
rsync -av --delete "$REPO_DIR/web/" "$DEPLOY_DIR/"

echo "Deployment completed at $(date)"
