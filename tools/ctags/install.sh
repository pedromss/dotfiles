#!/usr/bin/env bash

skip_if_os_is 'rpi'

ln -sfv "$DOTFILES_FULL_PATH/tools/ctags/.ctags" "$DOTFILES_USER_HOME/.ctags"
if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  install_with_pkg_manager
fi

