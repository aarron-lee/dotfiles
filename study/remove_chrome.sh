#!/bin/bash
FLATPAK_DESKTOP_CHROME="/var/lib/flatpak/exports/share/applications/com.google.Chrome.desktop"

if [[ -f $FLATPAK_DESKTOP_CHROME ]]; then
    # 1. Elevate privileges if not root
    if [ "$EUID" -ne 0 ]; then
        echo "Elevating privileges..."
        exec pkexec "$0" "$@"
    fi

    # 2. Get the invoking user's home directory
    # If PKEXEC_UID is set, look up that user; otherwise fall back to SUDO_USER or current user
    if [ -n "$PKEXEC_UID" ]; then
        INVOKING_USER=$(getent passwd "$PKEXEC_UID" | cut -d: -f1)
        HOME_DIR=$(getent passwd "$PKEXEC_UID" | cut -d: -f6)
    elif [ -n "$SUDO_USER" ]; then
        INVOKING_USER="$SUDO_USER"
        HOME_DIR=$(getent passwd "$SUDO_USER" | cut -d: -f6)
    else
        INVOKING_USER="$USER"
        HOME_DIR="$HOME"
    fi

    echo "Running as Root. Target user: $INVOKING_USER"
    echo "Target Home Directory: $HOME_DIR"

    APP_DIR="$HOME_DIR/.local/share/applications"
    CHROME_DESKTOP_FILE="$APP_DIR/com.google.Chrome.desktop"
    STUDY_DIR="$HOME_DIR/.study"

    echo $INVOKING_USER

    # 3. Ensure target directories exist before copying
    mkdir -p "$STUDY_DIR" "$APP_DIR"

    # 4. Perform file operations
    cp "$FLATPAK_DESKTOP_CHROME" "$STUDY_DIR/com.google.Chrome.desktop.bak"
    cp "$FLATPAK_DESKTOP_CHROME" "$CHROME_DESKTOP_FILE"

    # 5. Fix ownership (since root is copying into a user's home directory)
    chown -R "$INVOKING_USER:" "$STUDY_DIR/com.google.Chrome.desktop.bak" "$CHROME_DESKTOP_FILE"

    rm "$FLATPAK_DESKTOP_CHROME"
fi
