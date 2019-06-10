#! /usr/bin/env bash

function clone_if_not_exists() {
  if ! [ -d $2 ]
  then
    git clone $1 $2
  fi
}

function generate_brewfile() {
  if [[ "$1" == 'no' ]]
  then
    return
  fi

  echo 'Generating Brewfile'
  curl -sL https://raw.githubusercontent.com/pedromss/brewfile-generator/master/gen-brewfile.sh | sh
}

set -e
logs_dir=logs

source ./common.sh $@
mkdir -p $logs_dir

function setup_neovim_config() {
  if [[ "$1" == 'no' ]]
  then
    return
  fi
  mkdir -p "$XDG_CONFIG_HOME/nvim"
  mkdir -p "$XDG_DATA_HOME/nvim"

  make_link "$dotfiles_fullpath/.config/nvim" $XDG_CONFIG_HOME/nvim
  make_link "$dotfiles_fullpath/.local/share/nvim" $XDG_DATA_HOME/nvim
}

function install_zsh_plugins() {
  if [[ "$1" == 'no' ]]
  then 
    return
  fi

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
  clone_if_not_exists 'git@github.com:qoomon/zjump.git' $zsh_plugins_folder/zjump
  clone_if_not_exists 'git@github.com:zsh-users/zsh-autosuggestions.git' $zsh_plugins_folder/zsh-autosuggestions
  clone_if_not_exists 'git@github.com:robbyrussell/oh-my-zsh.git' $zsh_plugins_folder/oh-my-zsh
  clone_if_not_exists 'git@github.com:zsh-users/zsh-history-substring-search.git' $zsh_plugins_folder/zsh-history-substring-search
}

in_install_git='yes'
in_install_vim='yes'
in_install_nvim='yes'
in_install_zsh='yes'
in_install_zsh_plugins='yes'
in_generate_brewfile='no'
in_config_ctags='yes'
key="$1"
while [[ $# -gt 0 ]]
do
  case $key in
    --gen-brew)
      in_generate_brewfile='yes'
      shift
      ;;
    --no-zsh)
      in_install_zsh='no'
      shift
      ;;
    --no-nvim)
      in_install_nvim='no'
      shift
      ;;
    --no-zsh-plugins)
      in_install_zsh_plugins='no'
      shift
      ;;
    --no-git)
      in_install_git='no'
      shift
      ;;
    --no-vim)
      in_install_vim='no'
      shift
      ;;
    --no-ctags)
      in_install_ctags='no'
      shift
      ;;
  esac
done

function do_symlinks() {
  if [[ "$1" == 'no' ]]
  then
    return
  fi

  shift

  tolink=($@)
  for link in "${tolink[@]}"
  do
    make_link "$dotfiles_fullpath/$link" "$user_home"
  done
}
# ==================================================
# Files to link
# ==================================================
misc_files_tolink[0]='.ignore'

git_files_tolink[0]='tools/git/.gitconfig'

bash_files_tolink[0]='runcom/.bash_profile'

zsh_files_tolink[0]='zsh/.zshrc'
zsh_files_tolink[1]='zsh/.zfunctions'

vim_files_tolink[0]='vim/.vim'
vim_files_tolink[1]='vim/ultisnips'
vim_files_tolink[2]='vim/.vimrc'
vim_files_tolink[3]='vim/.ideavim'

ctags_files_tolink[0]='tools/ctags/.ctags'
# ==================================================
# Make links
# ==================================================
do_symlinks 'dolink' "${misc_files_tolink[@]}"
do_symlinks 'dolink' "${bash_files_tolink[@]}"

do_symlinks "$in_install_git" "${git_files_tolink[@]}"
do_symlinks "$in_install_zsh" "${zsh_files_tolink[@]}"
do_symlinks "$in_install_vim" "${vim_files_tolink[@]}"
do_symlinks "$in_install_ctags" "${ctags_files_tolink[@]}"
# ==================================================
# Tool dependant configs and opt out features
# ==================================================
setup_neovim_config "$in_install_nvim"
install_zsh_plugins "$in_install_zsh_plugins"
generate_brewfile "$in_generate_brewfile"
# ==================================================
# Shutdown
# ==================================================
echo 'Be sure to checkout:'
echo ' - https://github.com/ryanoasis/nerd-fonts'
echo ' - https://github.com/so-fancy/diff-so-fancy'

echo 'All done!'
