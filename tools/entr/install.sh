#!/usr/bin/env bash

set -x

source ../../runcom/.functions
source ../../common.sh
source ../../funcs.sh
source common.sh

touch-dotfiles

skip-if-installed 'entr'
mkdir -p "$DOTFILES_USER_HOME"

if is-macos ; then
  install-tool-from-git-repo \
    "$DOTFILES_ENTR_REPO" \
    "$DOTFILES_ENTR_VERSION" \
    './configure && make && make install'
    else
      install-with-pkg-manager 'entr'
    fi
