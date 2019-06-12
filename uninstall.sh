#! /usr/bin/env bash

in_hard='no'
home_dir="$HOME"
while [[ $# -gt 0 ]]
do
  case "$1" in
    --hard)
      in_hard='yes'
      shift
      ;;
    --home)
      home_dir="$2"
      shift
      ;;
  esac
done

source ./common.sh

if [[ "$in_hard" == 'yes' ]]
then
  [ -f ~/.fzf/uninstall ] && ~/.fzf/uninstall --xdg
fi

echo "Deleting symlinks from ${user_home}..."

for link in `find "$user_home" -maxdepth 1 -type l`
do
  if [[ $(readlink $link) == *"$dotfiles_folder"* ]]
  then
    echo "Deleting link: ${link[*]}"
    rm $link
  fi
done

echo 'Deleting symlinks to executables...'
for link in `find "$HOME/bin" \( -iname dotfiles\* \) -maxdepth 1 -type l`
do
  echo "Deleting link: ${link[*]}"
  rm $link
done

if [[ "$in_hard" == 'yes' ]]
then
  rm -rf "$zsh_plugins_folder"
  rm -rf ~/.fzf*
  rm -rf ~/.enhancd
  rm -rf ~/.local/share/nvim
  rm -rf ~/.config/nvim
  rm -rf ~/.vim
  rm -rf ~/dotfiles/vim/.vim/plugged
  rm -rf ~/dotfiles/vim/.vim/autoload/plug.vim*
fi

function uninstall_tools_from_custom_scripts() {
  echo "Removing installers in ${user_bin}..."
  for installer in `find "$user_bin" \( -name "${install_prefix}*" -o -name "${uninstall_prefix}*" \) -maxdepth 2 -type l`
  do
    echo "Removing link ${installer}..."
    rm -f "$installer"
  done

  echo "All installers removed from ${user_bin}"
}

uninstall_tools_from_custom_scripts

