#!/usr/bin/env bash

. "${DOTFILES_FULL_PATH:?}/funcs.sh"

skip-if-requested
quarantine
skip-if-installed

mkdir -p "$DOTFILES_USER_HOME"

if is-macos ; then
  install-tool-from-git-repo \
    "$DOTFILES_ENTR_REPO" \
    "$DOTFILES_ENTR_VERSION" \
    './configure && make && make install'
    else
      install-with-pkg-manager 'entr'
    fi
