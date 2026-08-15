#!/bin/bash

APPIMAGE_DIR_NAME="AppImages"


if [ "$(id -u)" -eq 0 ]; then
    echo "This script must not be run as root" >&2
    exit 1
fi

APP_DIR=$HOME/.local/share/applications
STUDY_DIR=$HOME/.study

if [[ -d "$HOME/Applications" && ! -d "$HOME/$APPIMAGE_DIR_NAME" ]]; then
    APPIMAGE_DIR_NAME="Applications"
fi

mkdir -p $STUDY_DIR

DESKTOP_FILE="$APP_DIR/zen_browser.desktop"
APPIMAGE_FILE="$HOME/$APPIMAGE_DIR_NAME/zen_browser.appimage"

if [[ -f "$STUDY_DIR/zen_browser.desktop" && -f "$STUDY_DIR/zen_browser.appimage" ]]; then
    echo "move Zen back to location"

    mv $STUDY_DIR/zen_browser.desktop $DESKTOP_FILE
    mv $STUDY_DIR/zen_browser.appimage $APPIMAGE_FILE
fi

rm -rf $APP_DIR/start-study.desktop
rm -rf $APP_DIR/stop-study.desktop

rm -rf $STUDY_DIR

echo "uninstall complete"
