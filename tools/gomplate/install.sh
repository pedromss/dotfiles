#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

skip-if-requested 'golang'
skip-if-requested 'gomplate'
skip-if-installed 'gomplate'
skip-if-tool-is-not-installed 'go'

# TODO add the uninstall script
GO111MODULE=off go get -v -u github.com/hairyhenderson/gomplate/cmd/gomplate
