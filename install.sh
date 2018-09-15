#! /usr/bin/env bash

set -e
logs_dir=logs

source ./common.sh
mkdir -p $logs_dir

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

echo 'Installing Conscript http://www.foundweekends.org/conscript ...'
./conscript/install.sh > $logs_dir/conscript-install.log
echo 'Finished installing conscript'

echo 'All done!'
