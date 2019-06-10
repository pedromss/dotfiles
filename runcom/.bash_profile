#!/usr/bin/env bash

source $HOME/dotfiles/runcom/.functions
source $HOME/dotfiles/runcom/.env
source $HOME/dotfiles/runcom/.aliases

[ -f ~/.bashrc ] && source ~/.bashrc
[ -f ~/.bash_prompt ] && source ~/.bash_prompt

source_recursive $HOME/dotfiles/tools

