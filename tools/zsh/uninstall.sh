#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

echo "Removing ZSH plugins folder at $DOTFILES_ZSH_PLUGINS_FOLDER..."
rm -rf "$DOTFILES_ZSH_PLUGINS_FOLDER"
echo 'ZSH Plugins removed'

destroy-at-home '.zshrc'
destroy-at-home '.zfunctions'

skip-if-not-installed 'zsh'
uninstall-with-pkg-manager 'zsh'
