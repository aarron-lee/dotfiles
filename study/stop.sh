#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    echo "This script must not be run as root" >&2
    exit 1
fi

# Get the current hour in 24-hour format (00-23)
# Strip leading zeros so Bash doesn't treat numbers like 08 or 09 as invalid octal
current_hour=$(date +%-H)

# Check if the hour is greater than or equal to 20 (8:00 PM)
if [ "$current_hour" -ge 20 ]; then
    echo "It is after 8 PM."
else
    echo "It is before 8 PM."
    exit 0
fi

pkexec true

if [ $? -ne 0 ]; then
    zenity --error --text="Authentication failed or cancelled!" 2>/dev/null
    exit 1
fi

# --- 3. Continue running as regular user ---
echo "Continuing as normal user: $(whoami)..."

# --------------------------------------------------

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
