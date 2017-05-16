#!/usr/bin/env bash

if bp_is_osx; then
    print_info "Dumping homebrew packages..."
    brew bundle dump --file="$BACKPACK_HOME/Brewfile" --force
fi
