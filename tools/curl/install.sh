#!/usr/bin/env bash

. "${DOTFILES_FULL_PATH:?}/funcs.sh"

skip-if-requested
skip-if-installed
install-with-pkg-manager
