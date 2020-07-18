#!/usr/bin/env bash

depends_on 'cargo'

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  if is_macos ; then
    install_with_pkg_manager
  else
    install_with_cargo
  fi
fi
