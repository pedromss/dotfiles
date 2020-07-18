#!/usr/bin/env bash

skip_if_installed 'pip'
if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  install_with_pkg_manager 'python-pip'
fi
