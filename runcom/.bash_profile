#!/usr/bin/env bash

source $HOME/dotfiles/runcom/.functions
source $HOME/dotfiles/runcom/.env
source $HOME/dotfiles/runcom/.aliases

[[ "$SHELL" =~ 'bash' ]] && [ -f ~/.bashrc ] && source ~/.bashrc
[[ "$SHELL" =~ 'bash' ]] && [ -f ~/.bash_prompt ] && source ~/.bash_prompt

source_recursive $HOME/dotfiles/tools

