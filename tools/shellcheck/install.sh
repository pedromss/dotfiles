#!/usr/bin/env bash

. "${DOTFILES_FULL_PATH:?}/funcs.sh"

save-alias 'shcheck' 'shellcheck --external-sources --format=tty --exclude=SC1090,1091 --shell=bash'

skip-if-installed 'shellcheck'
install-with-pkg-manager 'shellcheck'
