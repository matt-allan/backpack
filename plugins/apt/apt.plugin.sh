#!/usr/bin/env bash

print_info "Updating apt..."
sudo apt-get update

if [ -f "$BACKPACK_HOME/Aptfile" ]; then
    print_info "Installing apt packages..."
    cat "$BACKPACK_HOME/Aptfile" | xargs sudo apt-get install -y
fi

