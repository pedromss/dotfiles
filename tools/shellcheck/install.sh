#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-installed 'shellcheck'
install-with-pkg-manager 'shellcheck'
