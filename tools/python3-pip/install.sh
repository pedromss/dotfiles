#!/usr/bin/env bash

# shellcheck disable=SC1090
. "$DOTFILES_FULL_PATH/funcs.sh"
skip-if-installed 'pip3'
install-with-pkg-manager 'python3-pip'
