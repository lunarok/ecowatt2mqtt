#!/bin/bash

echo "Loading crontab file"

# Load the crontab file
crontab crontab

# Start cron
echo "Starting cron..."
crond -f
