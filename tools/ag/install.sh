#!/usr/bin/env bash

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  if is_macos ; then
    install_with_pkg_manager 'the_silver_searcher'
  else
    install_with_pkg_manager 'silversearcher-ag'
  fi
fi
