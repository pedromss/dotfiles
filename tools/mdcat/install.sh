#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-requested 'rust'
skip-if-requested 'mdcat'
skip-if-installed 'mdcat'
install-with-cargo 'mdcat'
