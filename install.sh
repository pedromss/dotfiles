#! /usr/bin/env bash

echo 'Dummy line to test vim-git-diff'

set -e

source ./common.sh

echo 'Performing symlinks...'

for dir in "${files_to_link[@]}";
do
  src="$dotfiles_fullpath/$dir"
  make_link $src $user_home
done

make_link "$dotfiles_fullpath/.config/nvim" $XDG_CONFIG_HOME/nvim
make_link "$dotfiles_fullpath/.local/share/nvim" $XDG_DATA_HOME/nvim

echo 'Copying bin folder...'

cp "$dotfiles_fullpath"/bin/* /usr/local/bin/

echo 'All done!'
