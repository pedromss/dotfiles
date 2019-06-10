#!/usr/bin/env bash

key="$1"
while [[ $# -gt 0 ]]
do
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
