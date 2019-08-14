#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

create-link-at-home 'tools/vim/.vim'
create-link-at-home 'tools/vim/ultisnips'
create-link-at-home 'tools/vim/.vimrc'
create-link-at-home 'tools/vim/.ideavim'
create-link-at-home 'tools/vim/.ideavimrc'

skip-if-installed 'vim'

install-with-pkg-manager 'vim'
vim -c +PlugInstall +qall 

