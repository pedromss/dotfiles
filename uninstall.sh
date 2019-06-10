#! /usr/bin/env bash

source ./common.sh

in_hard='no'
while [[ $# -gt 0 ]]
do
  case "$1" in
    --hard)
      in_hard='yes'
      shift
      ;;
  esac
done

echo 'Deleting symlinks...'

all_links=($(find $user_home -maxdepth 4 -type l))
for link in "${all_links[@]}"
do
  if [[ $(readlink $link) == *"$dotfiles_folder"* ]]
  then
    echo "Deleting link: ${link[*]}"
    rm $link
  fi
done

if [[ "$in_hard" == 'yes' ]]
then
  rm -rf "$zsh_plugins_folder"
  rm -rf ~/.fzf*
  rm -rf ~/.enhancd
fi
