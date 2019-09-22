#!/usr/bin/env bash 

. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-installed 'yq'
skip-if-os-is 'yq' 'rpi'

if is-debian ; then
  sudo add-apt-repository ppa:rmescandon/yq
  sudo apt-get update
fi

install-with-pkg-manager 'yq'

