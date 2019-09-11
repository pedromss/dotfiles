#!/usr/bin/env bash 

# shellcheck disable=SC1090
. "$DOTFILES_FULL_PATH/funcs.sh"

save-env 'NVM_DIR' "$XDG_CONFIG_HOME"

wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/$DOTFILES_NVM_VERSION/install.sh" | bash
