#!/usr/bin/env bash

if bp_installed npm; then
    if [ ! -${#npm_packages[@]} -eq 0 ]; then
        print_info "Installing NPM packages..."
        for package in "${npm_packages[@]}"; do
            npm install -g "$package"
        done
    fi
fi
