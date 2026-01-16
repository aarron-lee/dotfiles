#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    echo "This script must not be run as root" >&2
    exit 1
fi

APP_DIR=$HOME/.local/share/applications
STUDY_DIR=$HOME/.study

mkdir -p $STUDY_DIR

DESKTOP_FILE="$APP_DIR/zen_browser.desktop"
APPIMAGE_FILE="$HOME/AppImages/zen_browser.appimage"

if [[ -f "$DESKTOP_FILE" && -f "$APPIMAGE_FILE" ]]; then
    echo "Zen Browser is fully installed."

    mkdir -p $HOME/.local/share/icons

    cp ../icons/study.png $HOME/.local/share/icons

    mkdir -p $APP_DIR

    cat <<EOF > "$APP_DIR/start-study.desktop"
[Desktop Entry]
Type=Application
Name=Start Studying
Exec=$STUDY_DIR/start.sh
Icon=study
EOF

    cat <<EOF > "$APP_DIR/stop-study.desktop"
[Desktop Entry]
Type=Application
Name=Stop Studying
Exec=$STUDY_DIR/stop.sh
Icon=study
EOF


    cp ./start.sh $STUDY_DIR
    cp ./stop.sh $STUDY_DIR

    sudo chcon -u system_u -r object_r --type=bin_t $STUDY_DIR/start.sh
    sudo chcon -u system_u -r object_r --type=bin_t $STUDY_DIR/stop.sh

    echo "study scripts install complete"
else
    echo "Installation incomplete: one or more files are missing."
    exit 1
fi
