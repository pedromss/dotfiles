#!/usr/bin/env bash

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  if is_ubuntu ; then
    install_with_pkg_manager 'apt-utils'
  fi
  install_with_pkg_manager 'tmux'
fi



