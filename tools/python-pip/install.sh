#!/usr/bin/env bash

skip-if-installed 'pip'
if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  install-with-pkg-manager 'python-pip'
fi
