#!/usr/bin/env bash

if test ! "$(which composer)"; then
    print_info "Installing composer..."
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    chmod +x /usr/local/bin/composer
fi

print_info "Installing composer packages..."
composer global install
