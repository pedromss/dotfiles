#!/usr/bin/env bash

# shellcheck source=/dev/null
source "$HOME/dotfiles/runcom/.custom_profile"

set -o vi
# shellcheck source=/dev/null
[ -f ~/.bashrc ] && source ~/.bashrc
# shellcheck source=/dev/null
[ -f ~/.bash_prompt ] && source ~/.bash_prompt

