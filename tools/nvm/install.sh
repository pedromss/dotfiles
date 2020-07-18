#!/usr/bin/env bash

skip_if_os_is 'rpi'

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  #wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/$DOTFILES_NVM_VERSION/install.sh" | bash
  curr=$(pwd)
  mkdir -p "$DOTFILES_NVM_DIR"
  git clone https://github.com/nvm-sh/nvm.git "$DOTFILES_NVM_DIR"
  git checkout v0.35.2
  cd "$curr" || exit 1
fi
