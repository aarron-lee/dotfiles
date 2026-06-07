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

REPO_PATH="$NOTE_DIR"
COMMIT_MSG="vault sync: \$(date '+%Y-%m-%d %H:%M:%S')"

# ==============================================================================
# HELPER FUNCTIONS
# ==============================================================================
notify_user() {
    local title="$1"
    local message="$2"
    local urgency="\${3:-normal}"

    if command -v notify-send &> /dev/null; then
        notify-send -u "\$urgency" "\$title" "\$message"
    fi
    echo "[\$(date '+%Y-%m-%d %H:%M:%S')] [\$title] \$message" >&2
}

# ==============================================================================
# MAIN ROUTINE
# ==============================================================================

if [ ! -d "\$REPO_PATH/.git" ]; then
    notify_user "Git Sync Error" "Repository path '\$REPO_PATH' is not a valid Git repo." "critical"
    exit 1
fi

cd "\$REPO_PATH" || exit 1

# Stage changes
git add -A

# Commit if changes exist
if ! git diff-index --quiet HEAD --; then
    git commit -m "\$COMMIT_MSG"
fi

# Fetch remote
if ! git fetch origin; then
    echo "Git Sync Warning" "Failed to fetch remote. Offline?"
    exit 1
fi

# Dry-run merge check
if ! git merge origin/\$(git branch --show-current) --no-commit --no-ff &> /dev/null; then
    git merge --abort
    notify_user "Git Sync CONFLICT" "Merge conflict in \$REPO_PATH! Sync aborted." "critical"
    exit 1
fi

if [ -f .git/MERGE_HEAD ]; then
    git commit --no-edit
fi

# Push changes
if git push origin "\$(git branch --show-current)"; then
    echo "Git Sync Success" "Notes successfully synced."
else
    notify_user "Git Sync Error" "Failed to push updates." "critical"
    exit 1
fi
EOF

cat <<EOF > "$CONFIG_DIR/resume.sh"
#!/bin/bash

cd $NOTE_DIR

git pull

EOF

chmod +x $CONFIG_DIR/sync.sh
chmod +x $CONFIG_DIR/resume.sh

systemctl daemon-reload --user

systemctl enable --user --now $APP_NAME.timer
systemctl enable --user --now $APP_NAME.service
systemctl enable --user --now $APP_NAME-on-internet.service
