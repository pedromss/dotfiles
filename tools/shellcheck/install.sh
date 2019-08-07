#!/usr/bin/env bash

if ! [ "$(command -v shellcheck)" ]; then
  install-with-pkg-manager 'shellcheck'
else
  echo 'skipping: shellcheck is already installed'
fi
