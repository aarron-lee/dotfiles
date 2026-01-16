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
    echo "move Zen to temporary location"

    mv $DESKTOP_FILE $STUDY_DIR
    mv $APPIMAGE_FILE $STUDY_DIR
else
    exit 1
fi
