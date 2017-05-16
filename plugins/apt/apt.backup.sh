#!/usr/bin/env bash

if bp_is_linux; then
    print_info "Dumping apt packages..."
    # see http://askubuntu.com/questions/2389/generating-list-of-manually-installed-packages-and-querying-individual-packages
    comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u) > "$BACKPACK_CUSTOM/Aptfile"
fi
