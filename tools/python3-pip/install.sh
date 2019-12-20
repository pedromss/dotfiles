#!/usr/bin/env bash

skip-if-installed 'pip3'
if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  install-with-pkg-manager 'python3-pip'
fi
