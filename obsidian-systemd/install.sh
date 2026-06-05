#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    echo "This script must not be run as root" >&2
    exit 1
fi
SYSTEMD_DIR=$HOME/.config/systemd/user
mkdir -p $SYSTEMD_DIR

echo $SYSTEMD_DIR

APP_NAME=obsidian-notes-monitor
NOTE_DIR=$HOME/Development/obsidian-notes
CONFIG_DIR=$HOME/.config/$APP_NAME

# disable if currently running
systemctl disable --user --now $APP_NAME.timer
systemctl disable --user --now $APP_NAME.service
systemctl disable --user --now $APP_NAME-on-internet.service

# ========================================

mkdir -p $CONFIG_DIR

cat <<EOF >  "$SYSTEMD_DIR/$APP_NAME.service"
[Unit]
Description=Run note sync script

[Service]
Type=oneshot
ExecStart=/usr/bin/bash $CONFIG_DIR/sync.sh

[Install]
WantedBy=default.target
EOF

cat <<EOF >  "$SYSTEMD_DIR/$APP_NAME-on-internet.service"
[Unit]
Description=Run script on network restore
After=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/bin/bash $CONFIG_DIR/resume.sh

[Install]
WantedBy=default.target
EOF

cat <<EOF > "$SYSTEMD_DIR/$APP_NAME.timer"
[Unit]
Description=Run note sync every 1 minutes

[Timer]
# Run 1 minutes after the timer unit is activated
OnActiveSec=1min
# Run every 1 minutes thereafter
OnUnitActiveSec=1min
# Optional: Ensures the job runs immediately if a cycle was missed while powered off
Persistent=true

[Install]
WantedBy=timers.target
EOF


cat <<EOF > "$CONFIG_DIR/sync.sh"
#!/bin/bash

cd $NOTE_DIR

git stash
git pull
git stash pop

if [ -n "\$(git status --short)" ]; then
  echo "Changes detected in $NOTE_DIR: Proceeding with update."
  # Add your git add/commit logic here
  git add -A
  git commit -m "sync update from desktop $(date '+%Y-%m-%d %H:%M:%S')"
  git push
else
  echo "Clean as a whistle: Nothing to commit."
fi
EOF

cat <<EOF > "$CONFIG_DIR/resume.sh"
#!/bin/bash

cd $NOTE_DIR

git stash
git pull
git stash pop

EOF

chmod +x $CONFIG_DIR/sync.sh
chmod +x $CONFIG_DIR/resume.sh

systemctl daemon-reload --user

systemctl enable --user --now $APP_NAME.timer
systemctl enable --user --now $APP_NAME.service
systemctl enable --user --now $APP_NAME-on-internet.service
