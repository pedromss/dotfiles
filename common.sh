#!/usr/bin/env bash

user_home="$HOME"
echo "POSITIONAL before common: $POSITIONAL"
while [[ $# -gt 0 ]]
do
  case "$1" in
    --user-home)
      user_home="$2"
      shift 2
      ;;
    *)
      for x in "${POSITIONAL[@]}" ; do
        if [[ "$x" == "$1" ]]; then
          add=0
        fi
      done
      (( ${add:-1} )) && POSITIONAL+=("$1")
      shift
      ;;
  esac
done

set -- "${POSITIONAL[@]}"
echo "POSITIONAL after common: $POSITIONAL"

dotfiles_folder='dotfiles'
user=${user_home##*/}
dotfiles_fullpath="$user_home/$dotfiles_folder"
tools_folder="$dotfiles_fullpath/tools"
tools_install_folder="$user_home/tool-repos"
zsh_plugins_folder=$user_home/zsh-plugin-repos
user_bin="$user_home/bin"
install_prefix="installdot-"
uninstall_prefix="uninstalldot-"

mkdir -p "$tools_install_folder"

[ -d $user_home ] || { echo >&2 "Home directory [${user_home}] is not set"; exit 1; }
[ -d "$dotfiles_fullpath" ] || { echo "No dotfiles directory under $HOME"; exit 2; }

set +e
[ -d "$user_bin" ] || { echo "Creating ${user_bin}..."; mkdir -p "$user_bin"; }
[ -d "$tools_folder" ] || { echo "Creating ${tools_folder}..."; mkdir -p "$tools_folder"; }
set -e

source "$dotfiles_fullpath/runcom/.custom_profile"
