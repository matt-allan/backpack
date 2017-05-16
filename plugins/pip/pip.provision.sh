#!/usr/bin/env bash

if [ -f "$BACKPACK_CUSTOM/requirements.txt" ]; then
    print_info "Installing pip packages..."
    pip install -r "$DIR/requirements.txt"
fi
