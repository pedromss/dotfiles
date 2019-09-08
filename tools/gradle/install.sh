#!/usr/bin/env bash

# shellcheck disable=SC1090
. "$DOTFILES_FULL_PATH/funcs.sh"

save-alias 'gw' 'gw --console=plain'
save-alias 'gradle' 'gradle --console=plain'

skip-if-installed 'gradle'
install-with-sdkman 'gradle' "$DOTFILES_GRADLE_VERSION"
