#!/usr/bin/env bash

mkdir -p "$DOTFILES_ZSH_PLUGINS_FOLDER"

clone-from-github 'zplug/zplug' "$DOTFILES_ZPLUG_HOME"

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  install-with-pkg-manager
fi
