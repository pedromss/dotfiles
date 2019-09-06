#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

# Exa https://github.com/ogham/exa
save-alias 'lr' 'exa --group-directories-first --header --long --recurse --group --modified --git --all --all'
save-alias 'lrt' 'exa --group-directories-first --header --tree --long --recurse --group --modified --git'
save-alias 'l' 'exa --group-directories-first --header --long --group --modified --git --all --all'
save-alias 'ls' 'exa --group-directories-first -1'

skip-if-installed 'exa'
require-tool 'cargo'

cargo install --force exa
