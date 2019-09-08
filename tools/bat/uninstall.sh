#!/usr/bin/env bash 

# shellcheck disable=SC1090
. "$DOTFILES_FULL_PATH/funcs.sh"

uninstall-with-pkg-manager 'bat'
# TODO remove alias
# TODO remove env
