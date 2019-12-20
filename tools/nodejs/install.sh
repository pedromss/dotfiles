#!/usr/bin/env bash

skip-if-installed 'node'
if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  install-with-pkg-manager 'nodejs'
fi
