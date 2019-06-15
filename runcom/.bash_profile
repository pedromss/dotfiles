#!/usr/bin/env bash

source $HOME/dotfiles/runcom/.custom_profile

set -o vi
[ -f ~/.bashrc ] && source ~/.bashrc
[ -f ~/.bash_prompt ] && source ~/.bash_prompt

