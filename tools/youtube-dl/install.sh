#!/usr/bin/env bash 

skip_if_os_is 'rpi'
if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  install_with_pkg_manager
fi

