#!/usr/bin/env bash

skip_if_os_is 'rpi'
skip_if_dir_exists "$DOTFILES_SDKMAN_DIR"

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  if ! command_exists 'zip' ; then
    install_with_pkg_manager 'zip'
  fi
  curl -sSL "https://get.sdkman.io" | bash
fi
