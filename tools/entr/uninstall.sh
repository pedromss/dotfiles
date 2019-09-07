#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

skip-if-not-installed 'entr'
uninstall-tool-from-git-repo "$DOTFILES_ENTR_REPO" 'make uninstall'
