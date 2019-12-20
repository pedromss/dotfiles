#!/usr/bin/env bash 

skip-if-os-is 'rpi'
if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  install-with-pkg-manager
fi

