#!/bin/ash

# Give executable rights to cron jobs.
chmod -R +x /etc/periodic

# Update the health status since the service is healthy when it is started.
health-status.sh

exec "$@"
