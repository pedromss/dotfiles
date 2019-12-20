#!/usr/bin/env bash

quarantine

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  install-with-pkg-manager
fi
