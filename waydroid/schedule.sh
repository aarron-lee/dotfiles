#!/usr/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root, use sudo" >&2
    exit 1
fi

HOME_DIR=$(getent passwd "$SUDO_USER" | cut -d: -f6)
HOME_USER="${SUDO_USER:-${USER}}"

CLEAR_SCRIPT=/var/$HOME_DIR/.local/bin/clear-waydroid-desktop-entries

SERVICE_FILE=/etc/systemd/system/clear-waydroid-entries.service

sudo rm $SERVICE_FILE

cat <<EOF > "$SERVICE_FILE"
[Unit]
Description=clear waydroid entries
# Only starts the service after the system is properly initialized
After=network.target

[Service]
# The user the script will run as (e.g., 'root' or a specific user)
User=$HOME_USER
# The full path to your script
ExecStart=$CLEAR_SCRIPT
# Type 'oneshot' is typical for cron-like tasks
Type=oneshot

[Install]
# This section is generally not needed for a timer-driven service,
# but can be useful if you wanted to enable it directly.
EOF

cat $SERVICE_FILE

TIMER_FILE=/etc/systemd/system/clear-waydroid-entries.timer

sudo rm $TIMER_FILE

cat <<EOF > "$TIMER_FILE"
[Unit]
Description=Runs clear-waydroid-entries.service every 10 minutes

[Timer]
# This is the key setting. It runs the associated service 10 minutes
# after the service unit was last *activated*.
OnUnitActiveSec=10min

# Optional: To make sure it runs 10 minutes after boot, too.
# OnBootSec=10min

Persistent=true

[Install]
WantedBy=timers.target
EOF

cat $TIMER_FILE

sudo systemctl daemon-reload
sudo systemctl restart clear-waydroid-entries.timer
sudo systemctl list-timers | grep clear-waydroid-entries
