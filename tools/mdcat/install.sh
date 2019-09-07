#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-requested 'rust'
skip-if-requested
skip-if-installed
install-with-cargo
