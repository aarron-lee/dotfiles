#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    echo "This script must not be run as root" >&2
    exit 1
fi

APP_DIR=$HOME/.local/share/applications
STUDY_DIR=$HOME/.study

mkdir -p $STUDY_DIR

CHROME_DESKTOP_FILE="$APP_DIR/com.google.Chrome.desktop"

if [[ -f "$STUDY_DIR/com.google.Chrome.desktop" ]]; then
  echo "move chrome back to location"

  mv $STUDY_DIR/com.google.Chrome.desktop $CHROME_DESKTOP_FILE
fi

DESKTOP_FILE="$APP_DIR/zen_browser.desktop"
APPIMAGE_FILE="$HOME/AppImages/zen_browser.appimage"

if [[ -f "$STUDY_DIR/zen_browser.desktop" && -f "$STUDY_DIR/zen_browser.appimage" ]]; then
    echo "move Zen back to location"

    mv $STUDY_DIR/zen_browser.desktop $DESKTOP_FILE
    mv $STUDY_DIR/zen_browser.appimage $APPIMAGE_FILE

    mv $STUDY_DIR/start-study.desktop $APP_DIR/start-study.desktop
    mv $APP_DIR/stop-study.desktop $STUDY_DIR
else
    exit 1
fi
