#!/usr/bin/env bash

echo 'Creating links...'
create_link_at_home 'tools/vim/.vim'
create_link_at_home 'tools/vim/ultisnips'
create_link_at_home 'tools/vim/.vimrc'
create_link_at_home 'tools/vim/.ideavim'
create_link_at_home 'tools/vim/.ideavimrc'

echo 'Check is skip'
skip_if_installed
if ! (( ${DOTFILES_SHOULD_STOP_CURRENT:-0} )) ; then

  echo 'Installing with package manager'
  install_with_pkg_manager

  echo 'Installing Vim Plug, the plugin manager'
  mkdir -p "$DOTFILES_FULL_PATH/tools/vim/.vim/autoload"
  curl -fLo "$DOTFILES_FULL_PATH/tools/vim/.vim/autoload/plug.vim" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

