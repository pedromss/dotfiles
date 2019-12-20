#!/usr/bin/env bash

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  install-with-pkg-manager 'silversearcher-ag'
fi
