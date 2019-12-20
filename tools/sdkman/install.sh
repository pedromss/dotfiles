#!/usr/bin/env bash

skip-if-os-is 'rpi'
skip-if-dir-exists "$DOTFILES_SDKMAN_DIR"

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  if ! command_exists 'zip' ; then
    install-with-pkg-manager 'zip'
  fi
  curl -sSL "https://get.sdkman.io" | bash
fi
