#!/usr/bin/env bash
main() {

    set -e

    XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
    BACKPACK_HOME=${BACKPACK_HOME:-$XDG_CONFIG_HOME/backpack}
    BACKPACK=${BACKPACK:-$HOME/.backpack}

    # Write the bin script and set permissions.
    cat << "EOF" > /usr/local/bin/backpack
#!/bin/bash

BACKPACK=${BACKPACK:-$HOME/.backpack}
source "$BACKPACK/backpack.sh"
EOF
    chmod +x /usr/local/bin/backpack

    if [ ! -d ~/.backpack ]; then
        echo 'Installing backpack...'
        # If git is available we can clone the repo directly.
        # Otherwise we have to download a tar and 'settle' later.
        if hash git >/dev/null 2>&1; then
           git clone git@github.com:yuloh/backpack.git ~/.backpack
        else
            echo 'Could not find git.  Installing from an archive instead.'
            echo 'Once git is installed run backpack settle to switch to a git installation.'
            curl -L https://github.com/yuloh/backpack/tarball/master | tar -xzv -C ~/.backpack
        fi
    fi

    if [ ! -d $BACKPACK_HOME ]; then
        mkdir -p $BACKPACK_HOME
    fi

    if [ ! -e "$BACKPACK_HOME/backpackrc" ]; then
        cp "$BACKPACK/templates/backpackrc" "$BACKPACK_HOME/backpackrc"
    fi

    echo
    printf "\e[0;32m  [✔] %s\e[0m\n" "Backpack is now installed!

    You can find your backpackrc file at $BACKPACK_HOME/backpackrc.
    "
}

main
