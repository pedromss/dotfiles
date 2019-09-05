#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-installed 'ag'
install-with-pkg-manager 'silversearcher-ag'
