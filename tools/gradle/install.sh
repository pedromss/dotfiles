#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

save-alias 'gw' 'gw --console=plain'
save-alias 'gwn' 'gw --console=plain --no-daemon'

