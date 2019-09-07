#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

create-tool-link-at-home 'zsh/.zshrc'
create-tool-link-at-home 'zsh/.zfunctions'

mkdir -p "$DOTFILES_ZSH_PLUGINS_FOLDER"

clone-from-github 'Cloudstek/zsh-plugin-appup.git' "$DOTFILES_ZSH_PLUGINS_FOLDER/appup"
clone-from-github 'hlissner/zsh-autopair.git' "$DOTFILES_ZSH_PLUGINS_FOLDER/zsh-autopair"
clone-from-github 'b4b4r07/enhancd.git' "$DOTFILES_ZSH_PLUGINS_FOLDER/enhancd"
clone-from-github 'zdharma/fast-syntax-highlighting' "$DOTFILES_ZSH_PLUGINS_FOLDER/fast-syntax-highlighting"
clone-from-github 'wfxr/forgit.git' "$DOTFILES_ZSH_PLUGINS_FOLDER/forgit"
clone-from-github 'supercrabtree/k.git' "$DOTFILES_ZSH_PLUGINS_FOLDER/k"
clone-from-github 'qoomon/zjump.git' "$DOTFILES_ZSH_PLUGINS_FOLDER/zjump"
clone-from-github 'robbyrussell/oh-my-zsh.git' "$DOTFILES_ZSH_PLUGINS_FOLDER/oh-my-zsh"
clone-from-github 'zsh-users/zsh-history-substring-search.git' "$DOTFILES_ZSH_PLUGINS_FOLDER/zsh-history-substring-search"
if ! is-rpi ; then
  # too heavy for the rpi shell
  clone-from-github 'zsh-users/zsh-autosuggestions.git' "$DOTFILES_ZSH_PLUGINS_FOLDER/zsh-autosuggestions"
fi

skip-if-installed 'zsh'
install-with-pkg-manager 'zsh'

