#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

save-alias 'gwc' 'gw --console=plain'
save-alias 'gwn' 'gw --no-daemon'
save-alias 'gwcn' 'gw --console=plain --no-daemon'

