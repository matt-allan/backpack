#!/usr/bin/env bash

if bp_is_linux; then
    print_info "Updating apt..."
    sudo apt-get update

    if [ -f "$BACKPACK_HOME/Aptfile" ]; then
        print_info "Installing apt packages..."
        <"$BACKPACK_HOME/Aptfile" xargs sudo apt-get install -y
    fi
fi

