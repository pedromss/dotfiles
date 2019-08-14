#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-installed 'exa'
require-tool 'cargo'

cargo install exa
