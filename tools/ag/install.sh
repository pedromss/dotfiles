#!/usr/bin/env bash

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  if is-macos ; then
    install-with-pkg-manager 'the_silver_searcher'
  else
    install-with-pkg-manager 'silversearcher-ag'
  fi
fi
