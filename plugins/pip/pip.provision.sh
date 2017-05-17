#!/usr/bin/env bash

if [ -f "$BACKPACK_HOME/requirements.txt" ]; then
    print_info "Installing pip packages..."
    pip install -r "$BACKPACK_HOME/requirements.txt"
fi
