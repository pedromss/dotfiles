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
dotfiles_folder='.dotfiles'
dotfiles_fullpath=''
user_home=$HOME
files_to_link=(runcom/.bash_profile .gitconfig runcom/.aliases runcom/.env vim/.vim vim/.vimrc vim/.ideavim zsh/.zshrc .tern-project .ctags conscript/.conscript)
# =========================
# script
# =========================
# Make sure a user is specified
if [ ! -d $user_home ]
then
  echo 'Home directory not set.'
  exit 1
fi

echo "Installing in $HOME"

# Make sure the .dotfiles directory exists
dotfiles_fullpath="$user_home/$dotfiles_folder"
if [ ! -d "$dotfiles_fullpath" ]
then
  echo "No .dotfiles directory under $HOME"
  exit 2
fi

echo "Found the dotfiles directory in $dotfiles_fullpath"

# source all bash configs

for f in $dotfiles_fullpath/runcom/.[^.]*;
do
  echo "Sourcing $f..."
  source "$f"
done

