#!/usr/bin/env bash

if [ -f "$DOTFILES_FULL_PATH"/tools/vim/.vim/autoload/plug.vim ]; then
  export DOTFILES_TOOL_ALREADY_INSTALLED=1
else
  curl -fLo "$DOTFILES_FULL_PATH"/tools/vim/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

