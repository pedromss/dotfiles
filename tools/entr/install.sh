#!/usr/bin/env bash

set -x

source ../../runcom/.functions
source ../../common.sh
source common.sh

skip-if-installed 'entr'

if is-macos ; then
  install-tool-from-git-repo \
    "$DOTFILES_ENTR_REPO" \
    "$DOTFILES_ENTR_VERSION" \
    './configure && make && make install'
    else
      install-with-pkg-manager 'entr'
    fi
