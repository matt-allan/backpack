#!/usr/bin/env bash

if [ ! -e ~/.ssh/id_rsa.pub ]; then
    print_info "Generating an ssh key, copying it to the clipboard, and adding it to your keychain..."
    ssh-keygen -t rsa -N "" -f id_rsa
    if [[ $(uname) == "Darwin" ]]; then
        pbcopy < ~/.ssh/id_rsa.pub
    else
        xclip -selection clipboard < ~/.ssh/id_rsa.pub
    fi
    ssh-add -K ~/.ssh/id_rsa
fi
