#! /usr/bin/env bash

# =========================
# functions
# =========================
make_link() {
  ln -sfv $1 $2
}
# =========================
# variables
# =========================
user=$1
dotfiles_folder='.dotfiles'
dotfiles_fullpath=''
user_home="/Users/$user"
files_to_link=(runcom/.bash_profile runcom/.aliases runcom/.env vim/.vim vim/.vimrc vim/.ideavim zsh/.zshrc .tern-project)
# =========================
# script
# =========================
# Make sure a user is specified
if [ ! $user ]
then
  echo 'Please specify a user'
  exit 1
fi

echo "Installing for user $user..."

# Make sure the .dotfiles directory exists
dotfiles_fullpath="/Users/$user/$dotfiles_folder"
if [ ! -d "$dotfiles_fullpath" ]
then
  echo "No .dotfiles directory under /Users/$user"
  exit 2
fi

echo "Found the dotfiles directory in $dotfiles_fullpath"

# source all bash configs

for f in $dotfiles_fullpath/runcom/.[^.]*;
do
  echo "Sourcing $f..."
  source "$f"
done

