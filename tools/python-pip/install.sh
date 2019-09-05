#!/usr/bin/env bash

# shellcheck disable=SC1090
. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-installed 'pip'
install-with-pkg-manager 'python-pip'
