#!/usr/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

HOME_DIR=$(getent passwd "$SUDO_USER" | cut -d: -f6)

WAYDROID_RESTART_BIN=/usr/local/bin/waydroid-force-restart

cp ./waydroid-force-restart.desktop "$HOME_DIR/.local/share/applications/waydroid-force-restart.desktop"

cp ./waydroid-force-restart $WAYDROID_RESTART_BIN

chmod +x $WAYDROID_RESTART_BIN

cat <<-EOF > "/etc/sudoers.d/waydroid-force-restart"
ALL ALL=(ALL) NOPASSWD: $WAYDROID_RESTART_BIN
EOF
