#!/usr/bin/env bash 

# TODO add the uninstall script

# shellcheck disable=SC1090
. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-requested 'nodejs'
skip-if-installed 'node'
install-with-pkg-manager 'nodejs'
