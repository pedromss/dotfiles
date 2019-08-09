#!/usr/bin/env bash 

. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-installed 'ctags'
install-with-pkg-manager 'ctags'
create-link-at-home 'tools/ctags/.ctags'

