#!/usr/bin/env bash

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
BACKPACK_HOME=${BACKPACK_HOME:-$XDG_CONFIG_HOME/backpack}
BACKPACK=${BACKPACK:-$HOME/.backpack}

# shellcheck source=templates/backpackrc
if [ -e "$BACKPACK_HOME/backpackrc" ]; then
    source "$BACKPACK_HOME/backpackrc"
fi

if [ -${#plugins[@]} -eq 0 ]; then
    plugins=()
fi

# shellcheck source=lib/functions.sh
source "$BACKPACK/lib/functions.sh"

bp_backup() {
    for plugin in "${plugins[@]}"; do
        bp_load_plugin "$plugin" backup
    done
}

# help
bp_help() {
    print_info 'Usage:'
    echo '  backpack {backup, bootstrap, provision, settle}'
    print_info 'Arguments:'
    echo '  backup          Backup installed packages, settings, etc to your backpack home directory.'
    echo '  provision       Provision the machine.  Runs all plugins in the order they are listed in your backpackrc.'
    echo '  settle          Replace an archive backpack installation with a git repo to allow updating.'
    echo '  update          Update the backpack installation.'
}

bp_provision() {
    # Load plugins
    for plugin in "${plugins[@]}"; do
        bp_load_plugin "$plugin" provision
    done
}

bp_settle() {
    if [ ! -d "$BACKPACK/.git" ]; then
        bp_trash "$BACKPACK"
        git clone git@github.com:yuloh/backpack.git "$BACKPACK"
        print_success "Backpack settled."
    fi
}

bp_update() {
    cd "$BACKPACK" || exit
    if git pull --rebase --stat origin master; then
        print_success "Backpack has been updated to the latest version."
    else
        print_error "There was an error updating."
    fi
}


case "$1" in
    backup)
        bp_backup
        ;;
    provision)
        bp_provision
        ;;
    settle)
        bp_settle
        ;;
    update|upgrade)
        bp_update
        ;;
    *)
        bp_help
        ;;
esac
