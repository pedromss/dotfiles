#!/usr/bin/env bash

if [[ "$OSTYPE" =~ 'darwin' ]]; then
  # assume mac
  [ $(command -v brew) ] || { echo 'brew needs to be installed to install tmux'; exit 1; }
  brew install tmux
else
  # fallback to debian/rasbian
  sudo apt-get install tmux
fi
