#!/usr/bin/env bash

depends_on 'go'

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  go get -v github.com/hairyhenderson/gomplate/cmd/gomplate
fi
