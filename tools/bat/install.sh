#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-requested 'rust'
skip-if-requested

save-alias 'cat' 'bat'
save-env 'BAT_THEME' '1337'

skip-if-installed
install-with-cargo
