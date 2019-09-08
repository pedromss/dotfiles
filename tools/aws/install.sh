#!/usr/bin/env bash

# TODO uninstall script

# shellcheck disable=SC1090
. "$DOTFILES_FULL_PATH/funcs.sh"

# only if working with AWS, like in the job
quarantine 'aws'
save-alias 'awscf' 'aws cloudformation'

skip-if-installed 'aws'
install-with-pkg-manager 'aws'

