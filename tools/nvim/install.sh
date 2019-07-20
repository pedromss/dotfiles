#!/usr/bin/env bash

. ../../runcom/.functions
. ../../funcs.sh
. funcs.sh

skip-if-requested 'nvim' $in_install_nvim
mkdir -p "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_DATA_HOME/nvim"

#make_link "$dotfiles_fullpath/tools/nvim/init.vim" "$HOME/.config/nvim/init.vim"
create-nest-at-home "init.vim" "/.config/nvim/init.vim"
