#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

save-alias 'gw' 'gw --console=plain'
save-alias 'gradle' 'gradle --console=plain'

skip-if-installed 'gradle'
echo 'Gradle should be installed through SDKMAN'
