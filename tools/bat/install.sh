#!/usr/bin/env bash

depends_on 'cargo'

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  install_with_cargo
fi
