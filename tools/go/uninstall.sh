#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

rm -rf "$GOPATH"
rm -rf "$GOROOT"
sudo rm -rf /usr/local/go
