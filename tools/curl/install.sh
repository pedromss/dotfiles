#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

skip-if-requested 'curl'
skip-if-installed 'curl'
install-with-pkg-manager 'curl'
