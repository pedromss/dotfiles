#! /usr/bin/env bash

function clone_if_not_exists() {
  if ! [ -d $2 ]
  then
    git clone $1 $2
  fi
}

function generate_brewfile() {
  echo 'Generating Brewfile'
  curl -sL https://raw.githubusercontent.com/pedromss/brewfile-generator/master/gen-brewfile.sh | sh
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

key="$1"
while [[ $# -gt 0 ]]
do
  case $key in
    --gen-brew)
      generate_brewfile
      shift
      ;;
  esac
done

zsh_plugins_folder=$user_home/zsh-plugin-repos
mkdir -p $zsh_plugins_folder
clone_if_not_exists 'git@github.com:Valiev/almostontop.git' $zsh_plugins_folder/almostontop
clone_if_not_exists 'git@github.com:Cloudstek/zsh-plugin-appup.git' $zsh_plugins_folder/appup
clone_if_not_exists 'git@github.com:gretzky/auto-color-ls.git' $zsh_plugins_folder/auto-color-ls
clone_if_not_exists 'git@github.com:hlissner/zsh-autopair.git' $zsh_plugins_folder/zsh-autopair
clone_if_not_exists 'git@github.com:b4b4r07/enhancd.git' $zsh_plugins_folder/enhancd
clone_if_not_exists 'https://github.com/zdharma/fast-syntax-highlighting' $zsh_plugins_folder/fast-syntax-highlighting
clone_if_not_exists 'git@github.com:wfxr/forgit.git' $zsh_plugins_folder/forgit
clone_if_not_exists 'git@github.com:supercrabtree/k.git' $zsh_plugins_folder/k
clone_if_not_exists 'git@github.com:molovo/tipz.git' $zsh_plugins_folder/tipz
clone_if_not_exists 'git@github.com:qoomon/zjump.git' $zsh_plugins_folder/zjump
clone_if_not_exists 'git@github.com:zsh-users/zsh-autosuggestions.git' $zsh_plugins_folder/zsh-autosuggestions
clone_if_not_exists 'git@github.com:robbyrussell/oh-my-zsh.git' $zsh_plugins_folder/oh-my-zsh
clone_if_not_exists 'git@github.com:zsh-users/zsh-history-substring-search.git' $zsh_plugins_folder/zsh-history-substring-search
# CONSCRIPT
#echo 'Installing Conscript http://www.foundweekends.org/conscript ...'
#./conscript/install.sh > $logs_dir/conscript-install.log
#echo 'Finished installing conscript'

echo 'Be sure to checkout:'
echo ' - https://github.com/ryanoasis/nerd-fonts'
echo ' - https://github.com/so-fancy/diff-so-fancy'

echo 'All done!'
