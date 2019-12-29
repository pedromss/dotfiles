#!/usr/bin/env bash

skip-if-os-is 'rpi'

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/$DOTFILES_NVM_VERSION/install.sh" | bash
fi
