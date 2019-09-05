#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

skip-if-installed 'ag'
install-with-pkg-manager 'silversearcher-ag'
