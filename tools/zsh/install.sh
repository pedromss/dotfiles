#!/usr/bin/env bash

. ../../runcom/.functions
. ../../funcs.sh

zsh_plugins_folder="$HOME/zsh-plugin-repos"
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
    --zsh-plugins-folder)
      zsh_plugins_folder="$2"
      shift 2
      ;;
    --verbose)
      verbose=1
      shift
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

(( ${verbose:-0} )) && set -x

set -- "$@" "${POSITIONAL[@]}"
skip-if-installed 'zsh'
install-with-pkg-manager 'zsh'

create-link-at-home '.zshrc'
create-link-at-home '.zfunctions'

skip-if-requested 'zsh-plugins' "$install_zsh_plugins"

mkdir -p "$1"

clone-from-github 'Cloudstek/zsh-plugin-appup.git' "$zsh_plugins_folder/appup"
clone-from-github 'hlissner/zsh-autopair.git' "$zsh_plugins_folder/zsh-autopair"
clone-from-github 'b4b4r07/enhancd.git' "$zsh_plugins_folder/enhancd"
clone-from-github 'zdharma/fast-syntax-highlighting' "$zsh_plugins_folder/fast-syntax-highlighting"
clone-from-github 'wfxr/forgit.git' "$zsh_plugins_folder/forgit"
clone-from-github 'supercrabtree/k.git' "$zsh_plugins_folder/k"
clone-from-github 'qoomon/zjump.git' "$zsh_plugins_folder/zjump"
clone-from-github 'robbyrussell/oh-my-zsh.git' "$zsh_plugins_folder/oh-my-zsh"
clone-from-github 'zsh-users/zsh-history-substring-search.git' "$zsh_plugins_folder/zsh-history-substring-search"
if ! [ -f '/etc/os-release' ] || ! [[ $(cat /etc/os-release) =~ 'Raspbian' ]]; then
  clone-from-github 'zsh-users/zsh-autosuggestions.git' "$zsh_plugins_folder/zsh-autosuggestions"
fi
