#!/usr/bin/env bash 

. "$DOTFILES_FULL_PATH/funcs.sh"

if [ "$(command -v java)" ]; then
  ! [ -z "$SDKMAN_DIR" ] && save-env 'JAVA_HOME' "$SDKMAN_DIR/candidates/java/current"
fi

skip-if-installed 'java'

