#!/usr/bin/env bash 

# shellcheck disable=SC1090
. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-requested 'npm'
skip-if-installed 'npm'
install-with-pkg-manager
