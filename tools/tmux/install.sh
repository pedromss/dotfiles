#!/usr/bin/env bash

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  if is-ubuntu ; then
    install-with-pkg-manager 'apt-utils'
  fi
  install-with-pkg-manager 'tmux'
fi



