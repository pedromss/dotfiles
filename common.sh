#!/usr/bin/env bash

export DOTFILES_SOURCES_FILE='.dotfiles.sources'
export DOTFILES_SOURCES_NEW_FILE='.dotfiles.sources.new'
export DOTFILES_ALIAS_FILE='.dotfiles.alias'
export DOTFILES_ALIAS_NEW_FILE='.dotfiles.alias.new'
export DOTFILES_ENV_FILE='.dotfiles.env'
export DOTFILES_ENV_NEW_FILE='.dotfiles.env.new'
export DOTFILES_CONFIG_FILE='.dotfiles.config'
export DOTFILES_CONFIG_NEW_FILE='.dotfiles.config.new'
export DOTFILES_FOLDER='dotfiles'

if [ -z "$DOTFILES_USER_HOME" ]; then
  export DOTFILES_USER_HOME="$HOME"
  export DOTFILES_USER="${DOTFILES_USER_HOME##*/}"
fi

export DOTFILES_FULL_PATH="$DOTFILES_USER_HOME/$DOTFILES_FOLDER"

function save-env () {
  filename="$DOTFILES_FULL_PATH/$DOTFILES_ENV_NEW_FILE"
  export "$1"="$2"
  echo "export $1=$2" >> "$filename"
}

save-env 'DOTFILES_FULL_PATH' "$DOTFILES_FULL_PATH"
save-env 'DOTFILES_USER_HOME' "$DOTFILES_USER_HOME"
save-env 'XDG_CONFIG_HOME' "$DOTFILES_USER_HOME/.config"
save-env 'XDG_DATA_HOME' "$DOTFILES_USER_HOME/.local/share"

mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"

save-env 'DOTFILES_BIN' "${DOTFILES_FULL_PATH:?}/bin"
save-env 'DOTFILES_NVIM_REPO' "$DOTFILES_BIN/nvim-repo"
save-env 'DOTFILES_NVIM_INSTALLATION' "$DOTFILES_BIN/neovim"

save-env 'DOTFILES_ZSH_PLUGINS_FOLDER' "$DOTFILES_BIN/.zsh"
save-env 'DOTFILES_TOOLS_INSTALLATION_FOLDER' "$DOTFILES_BIN/tool-repos"

mkdir -p "$DOTFILES_TOOLS_INSTALLATION_FOLDER"

[ -d "$DOTFILES_USER_HOME" ] || { echo >&2 "Home directory [${DOTFILES_USER_HOME}] is not set"; exit 1; }
[ -d "$DOTFILES_FULL_PATH" ] || { echo "No dotfiles directory under $HOME"; exit 2; }

save-env 'DOTFILES_SDKMAN_DIR' "$DOTFILES_BIN/.sdkman"

save-env 'DOTFILES_GOLANG_VERSION' '1.12.6'
save-env 'DOTFILES_GOLANG_ROOT' 'go'
save-env 'DOTFILES_GOLANG_ROOT_PARENT' "$DOTFILES_BIN"
save-env 'DOTFILES_GOLANG_GOPATH' "${DOTFILES_USER_HOME:?}/go"

save-env 'DOTFILES_GRADLE_VERSION' '5.4'

save-env 'DOTFILES_FZF_VERSION' '0.18.0'

save-env 'DOTFILES_NVM_VERSION' 'v0.34.0'
