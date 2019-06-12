#!/usr/bin/env bash

dotfiles_folder='dotfiles'
user_home=${1:-"$HOME"}
user=${user_home##*/}
dotfiles_fullpath="$user_home/$dotfiles_folder"
tools_folder="$dotfiles_fullpath/tools"
zsh_plugins_folder=$user_home/zsh-plugin-repos
user_bin="$user_home/bin"
install_prefix="installdot-"
uninstall_prefix="uninstalldot-"

[ -d $user_home ] || { echo >&2 "Home directory [${user_home}] is not set"; exit 1; }
[ -d "$dotfiles_fullpath" ] || { echo "No dotfiles directory under $HOME"; exit 2; }

set +e
[ -d "$user_bin" ] || { echo "Creating ${user_bin}..."; mkdir -p "$user_bin"; }
[ -d "$tools_folder" ] || { echo "Creating ${tools_folder}..."; mkdir -p "$tools_folder"; }
[[ $(stat -c '%U' "$user_bin") != "root" ]] && sudo chown -R "${user}:${user}" "$user_bin"
set -e

source "$dotfiles_fullpath/runcom/.custom_profile"
