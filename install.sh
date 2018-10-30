#! /usr/bin/env bash

function clone_if_not_exists() {
  if ! [ -d $2 ]
  then
    git clone $1 $2
  fi
}

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

if [[ "$1" =~ gen-brew ]]
then
  echo 'Generating Brewfile'
  curl -sL https://raw.githubusercontent.com/pedromss/brewfile-generator/master/gen-brewfile.sh | sh
fi

zsh_plugins_folder=$user_home/zsh-plugin-repos
mkdir -p $zsh_plugins_folder
clone_if_not_exists 'git@github.com:Valiev/almostontop.git' $zsh_plugins_folder/almostontop
clone_if_not_exists 'git@github.com:Cloudstek/zsh-plugin-appup.git' $zsh_plugins_folder/appup
clone_if_not_exists 'git@github.com:gretzky/auto-color-ls.git' $zsh_plugins_folder/auto-color-ls
clone_if_not_exists 'git@github.com:hlissner/zsh-autopair.git' $zsh_plugins_folder/zsh-autopair
#clone_if_not_exists 'git@github.com:Tarrasch/zsh-bd.git' $zsh_plugins_folder/zsh-bd # enhancd does it as well
clone_if_not_exists 'git@github.com:b4b4r07/enhancd.git' $zsh_plugins_folder/enhancd
clone_if_not_exists 'https://github.com/zdharma/fast-syntax-highlighting' $zsh_plugins_folder/fast-syntax-highlighting
clone_if_not_exists 'git@github.com:wfxr/forgit.git' $zsh_plugins_folder/forgit
clone_if_not_exists 'git@github.com:supercrabtree/k.git' $zsh_plugins_folder/k

# CONSCRIPT
#echo 'Installing Conscript http://www.foundweekends.org/conscript ...'
#./conscript/install.sh > $logs_dir/conscript-install.log
#echo 'Finished installing conscript'

echo 'Be sure to checkout: https://github.com/ryanoasis/nerd-fonts'

echo 'All done!'
