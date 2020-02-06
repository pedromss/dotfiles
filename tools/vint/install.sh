#!/usr/bin/env bash 

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  install_with_pip 'pathlib'
  install_with_pip 'typing'
  install_with_pip 'vim-vint'
fi
