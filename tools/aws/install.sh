#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

save-alias 'awscf' 'aws cloudformation'

skip-if-installed 'aws'
install-with-pkg-manager 'aws'

