#!/usr/bin/env bash

print_error() {
    printf "\e[0;31m  [✖] %s\e[0m\n" "$1"
}

print_info() {
    printf "\n\e[0;35m %s\e[0m\n" "$1"
}

print_success() {
    printf "\e[0;32m  [✔] %s\e[0m\n" "$1"
}

bp_installed() {
    type -t "$1" > /dev/null
}

bp_brew_tapped() {
    brew tap | grep -q "$1"
}

bp_brew_installed() {
    [ -n "$(brew ls --versions "$1")" ]
}

bp_brew_cask_installed() {
    [ -n "$(brew cask ls --versions "$1")" ]
}

bp_trash() {
    if bp_installed trash; then
        trash "$1"
    else
        rm -fr "$1"
    fi
}

bp_confirm() {
    read -p "$1 " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] && return;
}
