#!/usr/bin/env bash

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    print_info "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

