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

# =========================
# script
# =========================
# Make sure a user is specified
if [ ! $user ]
then
  echo 'Please specify a user'
  exit 1
fi

# Make sure the .dotfiles directory exists
if [ ! -d "/Users/$user/.dotfiles" ]
then
  echo "No .dotfiles directory under /Users/$user"
  exit 2
fi

make_link "/Users/$user/.dotfiles/runcom/.bash_profile" ~
make_link "/Users/$user/.dotfiles/runcom/.aliases" ~
make_link "/Users/$user/.dotfiles/runcom/.env" ~
make_link "/Users/$user/.dotfiles/vim/.vimrc" ~
make_link "/Users/$user/.dotfiles/zsh/.zshrc" ~
make_link "/Users/$user/.dotfiles/tern/.tern-project" ~

