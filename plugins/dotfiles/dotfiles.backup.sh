#!/usr/bin/env bash

if [ ! -n "$dotfiles_path" ]; then
    dotfiles_path=~"$BACKPACK_HOME/dotfiles"
fi

app_cfg_path=$BACKPACK/plugins/dotfiles/apps
custom_app_cfg_path=$BACKPACK_HOME/plugins/dotfiles/apps

print_info "Backing up dotfiles..."

if [ -${#dotfiles[@]} -eq 0 ]; then
    dotfiles=()
fi

for app in "${dotfiles[@]}"; do
    # get the list of files to sync
    if [ -f "$custom_app_cfg_path/$app.cfg" ]; then
        files=$(<"$custom_app_cfg_path/$app.cfg")
    elif [ -f "$app_cfg_path/$app.cfg" ]; then
        files=$(<"$app_cfg_path/$app.cfg")
    else
        files=()
    fi

    for file in "${files[@]}"; do
        # If the file or directory exists and isn't a symlink
        if ( [ -f "$HOME/$file" ] || [ -d "$HOME/$file" ] ) &&
            [ ! -h "$HOME/$file" ]
        then
            # if it's already been backed up, confirm then delete the old one.
            if [ -f "$dotfiles_path/$file" ] || [ -d "$dotfiles_path/$file" ]; then
                if bp_confirm "$file is already backed up.  Overwrite it?"; then
                    bp_trash "$dotfiles_path/$file"
                fi
            fi

            print_info "$HOME/$file > $dotfiles_path/$file"
            mv "$HOME/$file" "$dotfiles_path/$file"
            ln -s "$dotfiles_path/$file" "$HOME/$file"
        fi
    done
done

