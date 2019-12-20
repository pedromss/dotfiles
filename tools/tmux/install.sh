#!/usr/bin/env bash

ln -sfv "$DOTFILES_TMUX_CONF_FILE" "$DOTFILES_USER_HOME/.tmux.conf" 
if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  if is-ubuntu ; then
    install-with-pkg-manager 'apt-utils'
  fi
  install-with-pkg-manager 'tmux'
fi



