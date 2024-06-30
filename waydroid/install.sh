#!/usr/bin/bash

cat <<EOF > "$HOME/.local/share/applications/waydroid-full-ui.desktop"
[Desktop Entry]
Type=Application
Name=Waydroid Full UI
Exec=waydroid-full-ui
Categories=X-WayDroid-App;
X-Purism-FormFactor=Workstation;Mobile;
Icon=waydroid
NoDisplay=false
EOF

cat <<EOF > "$HOME/.local/bin/waydroid-full-ui"
#!/usr/bin/bash

source /etc/default/waydroid-launcher

# Kill any previous remnants
pkexec /usr/libexec/waydroid-container-stop

# Launch Cage & Waydroid
pkexec /usr/libexec/waydroid-container-start

waydroid show-full-ui &

sleep 5

$HOME/.local/bin/clear-waydroid-desktop-entries
EOF

cat <<EOF > "$HOME/.local/bin/clear-waydroid-desktop-entries"
#!/bin/bash

rm $HOME/.local/share/applications/waydroid.*.desktop
EOF

chmod +x $HOME/.local/share/applications/waydroid-full-ui.desktop
chmod +x $HOME/.local/bin/waydroid-full-ui
chmod +x $HOME/.local/bin/clear-waydroid-desktop-entries
