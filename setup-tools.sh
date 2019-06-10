#!/usr/bin/env bash

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --install-conscript)
      version="$2"
      source $HOME/dotfiles/tools/conscript/install.sh
      install_conscript "$version"
      shift
      shift
      ;;
  esac
done
