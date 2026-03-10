#!/bin/bash

FLATPAK_POLICY_DIR=/var/lib/flatpak/extension/org.mozilla.firefox.systemconfig/x86_64/stable/policies/

sudo mkdir -p /etc/zen/policies
sudo mkdir -p $FLATPAK_POLICY_DIR

sudo cp ./policies.json /etc/zen/policies
sudo cp ./policies.json $FLATPAK_POLICY_DIR
