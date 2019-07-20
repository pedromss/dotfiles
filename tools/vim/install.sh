#!/usr/bin/env bash

. ../../runcom/.functions
. ../../funcs.sh
. funcs.sh

create-link-at-home '.vim'
create-link-at-home 'ultisnips'
create-link-at-home '.vimrc'
create-link-at-home '.ideavim'
create-link-at-home '.ideavimrc'

install-with-pkg-manager 'vim'
vim -c +PlugInstall +qall 

