#!/usr/bin/env bash

# Install vundle
if [ ! -e "$HOME/.vim/bundle/Vundle.vim"  ]; then
    print_info "Installing Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Install vundle plugins
print_info "Updating Vundle..."
vim -c VundleUpdate -c quitall
