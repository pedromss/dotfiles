#!/usr/bin/env bash

depends_on 'cargo'

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  if is-macos ; then
    install-with-pkg-manager
  else
    install-with-cargo
  fi
fi
