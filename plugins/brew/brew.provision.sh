#!/usr/bin/env bash

if bp_is_osx; then
    if test ! "$(which brew)"; then
      print_info "Installing homebrew..."
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    print_info "Updating homebrew..."
    brew update

    if [ -f "$BACKPACK_CUSTOM/Brewfile" ]; then
        print_info "Installing homebrew packages..."
        brew bundle --file="$BACKPACK_CUSTOM/Brewfile"
    fi

    print_info "Cleaning up homebrew..."
    brew cleanup
fi
