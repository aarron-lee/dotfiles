#!/bin/bash

# Define file paths
ZEN_POLICY="/etc/zen/policies/policies.json"
FLATPAK_POLICY="/var/lib/flatpak/extension/org.mozilla.firefox.systemconfig/x86_64/stable/policies/policies.json"

# Check if the first backup file exists to determine the current state
if [ -f "$ZEN_POLICY.old" ]; then
    echo "Restoring policies..."
    sudo mv "$ZEN_POLICY.old" "$ZEN_POLICY"
    sudo mv "$FLATPAK_POLICY.old" "$FLATPAK_POLICY"
    echo "Status: Policies are now ACTIVE."
else
    echo "Disabling policies..."
    sudo mv "$ZEN_POLICY" "$ZEN_POLICY.old"
    sudo mv "$FLATPAK_POLICY" "$FLATPAK_POLICY.old"
    echo "Status: Policies are now DISABLED (.old)."
fi

