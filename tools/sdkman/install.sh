#!/usr/bin/env bash 

# shellcheck disable=SC1090
. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-os-is 'sdkman' 'rpi'

save-env 'SDKMAN_DIR' "$DOTFILES_SDKMAN_DIR"
save-source "${DOTFILES_FULL_PATH:?}/tools/sdkman/.env.source"

skip-if-requested 'sdk'
skip-if-installed 'sdk'

curl -s "https://get.sdkman.io" | bash
