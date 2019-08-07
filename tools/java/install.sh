#!/usr/bin/env bash 

. "$DOTFILES_FULL_PATH/funcs.sh"

if [ "$(command -v java)" ]; then
  save-env 'JAVA_HOME' '/usr/libexec/java_home'
fi

skip-if-installed 'java'

