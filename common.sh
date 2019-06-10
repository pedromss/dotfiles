#!/usr/bin/env bash

dotfiles_folder='dotfiles'
dotfiles_fullpath=''
user_home=${1:-$HOME}
zsh_plugins_folder=$user_home/zsh-plugin-repos

# Make sure a user is specified
if [ ! -d $user_home ]
then
  echo 'Home directory not set.'
  exit 1
fi

# Make sure the dotfiles directory exists
dotfiles_fullpath="$user_home/$dotfiles_folder"
if [ ! -d "$dotfiles_fullpath" ]
then
  echo "No dotfiles directory under $HOME"
  exit 2
fi

echo "Found the dotfiles directory in $dotfiles_fullpath..."
# source all bash configs
for f in $dotfiles_fullpath/runcom/.[^.]*;
do
  echo "Sourcing $f..."
  source "$f"
done

