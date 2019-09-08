#!/usr/bin/env bash 

# shellcheck disable=SC1090
. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-os-is 'rpi'

save-env 'JAVA_HOME' "$DOTFILES_SDKMAN_DIR/candidates/java/current"
skip-if-requested 'java'
skip-if-installed 'java'

install-with-sdkman 'java' '8.0.222.hs-adopt'

