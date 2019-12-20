#!/usr/bin/env bash

echo 'Creating links...'
create-link-at-home 'tools/vim/.vim'
create-link-at-home 'tools/vim/ultisnips'
create-link-at-home 'tools/vim/.vimrc'
create-link-at-home 'tools/vim/.ideavim'
create-link-at-home 'tools/vim/.ideavimrc'

echo 'Check is skip'
skip-if-installed
if ! (( ${DOTFILES_SHOULD_STOP_CURRENT:-0} )) ; then

  echo 'Installing with package manager'
  install-with-pkg-manager

  echo 'Installing Vim Plug, the plugin manager'
  mkdir -p "$DOTFILES_FULL_PATH/tools/vim/.vim/autoload"
  curl -fLo "$DOTFILES_FULL_PATH/tools/vim/.vim/autoload/plug.vim" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

