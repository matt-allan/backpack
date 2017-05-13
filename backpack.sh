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
source $BACKPACK/lib/functions.sh

bp_backup() {
    for plugin in "${plugins[@]}"; do
        # shellcheck source=/dev/null
        if [ -f "$BACKPACK_HOME/plugins/$plugin/$plugin.backup.sh" ]; then
            source "$BACKPACK_HOME/plugins/$plugin/$plugin.backup.sh"
        elif [ -f "$BACKPACK/plugins/$plugin/$plugin.backup.sh" ]; then
            source "$BACKPACK/plugins/$plugin/$plugin.backup.sh"
        fi
    done
}

# help
bp_help() {
    print_info 'Usage:'
    echo '  backpack {backup, bootstrap, provision, settle}'
    print_info 'Arguments:'
    echo '  backup:                     Backup installed packages, settings, etc to your backpack home directory.'
    echo '  provision (default):        Provision the machine.  Runs all plugins in the order they are listed in your backpackrc.'
    echo '  settle:                     Replace an archive backpack installation with a git repo to allow updating.'
    echo '  update:                     Update the backpack installation.'
}

bp_provision() {
    # Load plugins
    for plugin in "${plugins[@]}"; do
        # shellcheck source=/dev/null
        if [ -f "$BACKPACK_HOME/plugins/$plugin/$plugin.plugin.sh" ]; then
            source "$BACKPACK_HOME/plugins/$plugin/$plugin.plugin.sh"
        elif [ -f "$BACKPACK/plugins/$plugin/$plugin.plugin.sh" ]; then
            source "$BACKPACK/plugins/$plugin/$plugin.plugin.sh"
        fi
    done
}

bp_settle() {
    if [ ! -d $BACKPACK/.git ]; then
        bp_trash $BACKPACK
        git clone git@github.com:yuloh/backpack.git $BACKPACK
    fi
}

case $1 in
    backup)
        bp_backup
        ;;
    -h|--help|help)
        bp_help
        ;;
    provision|*)
        bp_provision
        ;;
    settle)
        bp_settle
        ;;
esac
