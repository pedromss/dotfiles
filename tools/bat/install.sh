#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

save-alias 'cat' 'bat'

save-env 'BAT_THEME' '1337'

skip-if-installed 'bat'
require-tool 'cargo'
cargo install --force bat
