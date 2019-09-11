#!/usr/bin/env bash

export DOTFILES_SOURCES_FILE=".dotfiles.sources"
export DOTFILES_SOURCES_NEW_FILE=".dotfiles.sources.new"
export DOTFILES_ALIAS_FILE=".dotfiles.alias"
export DOTFILES_ALIAS_NEW_FILE=".dotfiles.alias.new"
export DOTFILES_ENV_FILE=".dotfiles.env"
export DOTFILES_ENV_NEW_FILE=".dotfiles.env.new"
export DOTFILES_CONFIG_FILE=".dotfiles.config"
export DOTFILES_CONFIG_NEW_FILE=".dotfiles.config.new"
export DOTFILES_FOLDER='dotfiles'

if [ -z "$DOTFILES_USER_HOME" ]; then
  export DOTFILES_USER_HOME="$HOME"
  export DOTFILES_USER="${DOTFILES_USER_HOME##*/}"
fi

export DOTFILES_FULL_PATH="$DOTFILES_USER_HOME/$DOTFILES_FOLDER"

export XDG_CONFIG_HOME="$DOTFILES_USER_HOME/.config"
export XDG_DATA_HOME="$DOTFILES_USER_HOME/.local/share"

mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"

export DOTFILES_BIN="${DOTFILES_FULL_PATH:?}/bin"
export DOTFILES_NVIM_REPO="$DOTFILES_BIN/nvim-repo"
export DOTFILES_NVIM_INSTALLATION="$DOTFILES_BIN/neovim"

export DOTFILES_TOOLS_FOLDER="$DOTFILES_FULL_PATH/tools"
export DOTFILES_TOOLS_INSTALLATION_FOLDER="$DOTFILES_FULL_PATH/tool-repos"
export DOTFILES_ZSH_PLUGINS_FOLDER="$DOTFILES_USER_HOME/zsh-plugin-repos"

mkdir -p "$DOTFILES_TOOLS_INSTALLATION_FOLDER"

[ -d "$DOTFILES_USER_HOME" ] || { echo >&2 "Home directory [${DOTFILES_USER_HOME}] is not set"; exit 1; }
[ -d "$DOTFILES_FULL_PATH" ] || { echo "No dotfiles directory under $HOME"; exit 2; }

set +e
[ -d "$DOTFILES_TOOLS_FOLDER" ] || { echo "Creating ${DOTFILES_TOOLS_FOLDER}..."; mkdir -p "$DOTFILES_TOOLS_FOLDER"; }
set -e

export DOTFILES_SDKMAN_DIR="$DOTFILES_BIN/.sdkman"

export DOTFILES_GOLANG_VERSION="1.12.6"
export DOTFILES_GOLANG_ROOT="go"
export DOTFILES_GOLANG_ROOT_PARENT="$DOTFILES_BIN"
export DOTFILES_GOLANG_GOPATH="${DOTFILES_USER_HOME:?}/go"

export DOTFILES_GRADLE_VERSION='5.4'

export DOTFILES_FZF_VERSION='0.18.0'

export DOTFILES_NVM_VERSION='v0.34.0'
