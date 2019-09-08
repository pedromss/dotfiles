#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

skip-if-not-installed 'git'
uninstall-with-pkg-manager 'git'
rm-link-at-home '.gitconfig'

