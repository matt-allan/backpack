#!/usr/bin/env bash
print_info "Dumping homebrew packages..."
brew bundle dump --file="$BACKPACK_HOME/Brewfile" --force
