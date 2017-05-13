#!/usr/bin/env bash

if ! xcode-select --print-path &> /dev/null; then
    print_info "Installing xcode-select"
    xcode-select --install
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done
fi
