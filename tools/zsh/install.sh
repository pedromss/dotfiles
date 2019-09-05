#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --no-zsh)
      install_zsh=0
      shift
      ;;
    --no-zsh-plugins)
      install_zsh_plugins=0
      shift
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

set -- "$@" "${POSITIONAL[@]}"

echo "Boo $install_zsh"
echo "Boo $install_zsh"
echo "Boo $install_zsh"
skip-if-requested 'zsh' "$install_zsh"
echo 'Installing boo...'
echo 'Installing boo...'
echo 'Installing boo...'

create-link-at-home '.zshrc'
create-link-at-home '.zfunctions'

skip-if-installed 'zsh'
install-with-pkg-manager 'zsh'

skip-if-requested 'zsh-plugins' "$DOTFILES_ZSH_PLUGINS_FOLDER"

mkdir -p "$1"

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
  clone-from-github 'zsh-users/zsh-autosuggestions.git' "$DOTFILES_ZSH_PLUGINS_FOLDER/zsh-autosuggestions"
fi
