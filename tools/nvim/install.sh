#!/usr/bin/env bash

. ../../runcom/.functions
. ../../funcs.sh

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --no-nvim)
      in_install_nvim=0
      shift
      ;;
    --verbose)
      verbose=1
      shift
      ;;
    --main-device)
      main_device=1
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

skip-if-requested 'nvim' $in_install_nvim
mkdir -p "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_DATA_HOME/nvim"

#make_link "$dotfiles_fullpath/tools/nvim/init.vim" "$HOME/.config/nvim/init.vim"
create-nest-at-home "init.vim" "/.config/nvim/init.vim"
