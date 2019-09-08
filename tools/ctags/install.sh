#!/usr/bin/env bash 

# shellcheck disable=SC1090
. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-os-is 'rpi'
skip-if-installed 'ctags'
install-with-pkg-manager 'ctags'
create-link-at-home 'tools/ctags/.ctags'

