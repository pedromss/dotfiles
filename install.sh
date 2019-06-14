#! /usr/bin/env bash

set -e
logs_dir=logs

in_username="$USER"
in_install_git='yes'
in_install_vim='yes'
in_install_nvim='yes'
in_install_zsh='yes'
in_install_rust='yes'
in_install_zsh_plugins='yes'
in_generate_brewfile='no'
in_config_ctags='yes'
in_install_fzf='yes'
in_fzf_version='0.18.0'
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --user)
      in_username=$2
      shift 2
      ;;
    --no-rust)
      in_install_rust='yes'
      shift
      ;;
    --gen-brew)
      in_generate_brewfile='yes'
      shift
      ;;
    --fzf-version)
      in_fzf_version=$2
      shift 2
      ;;
    --no-fzf)
      in_install_fzf='no'
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
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

set -- "${POSITIONAL[@]}"
source ./common.sh $@
mkdir -p $logs_dir

function clone_if_not_exists() {
  if ! [ -d $2 ]; then
    git clone --depth 1 $1 $2
  fi
}

function generate_brewfile() {
  if [[ "$1" == 'no' ]]; then
    return
  fi

  echo 'Generating Brewfile'
  curl -sL https://raw.githubusercontent.com/pedromss/brewfile-generator/master/gen-brewfile.sh | sh
}

function install_vim_plugins() {
  if [[ "$1" == 'no' ]] || ! command_exists vim
  then
    return
  fi

  vim -c +PlugInstall +qall
}

function install_fzf() {
  if [ -d "$HOME/.fzf" ] || [[ "$1" == 'no' ]]
  then
    return
  fi

  if ! command_exists git
  then
    echo 'Git is required to install fzf'
    exit 1
  fi

  fzf_version="$2"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  echo "Installing fzf@$fzf_version"
  cd ~/.fzf && git fetch --tags 1>/dev/null && git checkout $fzf_version
  ~/.fzf/install --key-bindings --completion --update-rc --no-fish
}

function setup_neovim_config() {
  if [[ "$1" == 'no' ]]
  then
    return
  fi
  mkdir -p "$XDG_CONFIG_HOME/nvim"
  mkdir -p "$XDG_DATA_HOME/nvim"

  make_link "$dotfiles_fullpath/.local/share/nvim" $XDG_DATA_HOME/nvim
  make_link "$dotfiles_fullpath/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim"
}

function install_zsh_plugins() {
  if [[ "$1" == 'no' ]]
  then
    return
  fi

  mkdir -p $2

  clone_if_not_exists 'https://github.com/Cloudstek/zsh-plugin-appup.git' $zsh_plugins_folder/appup
  clone_if_not_exists 'https://github.com/hlissner/zsh-autopair.git' $zsh_plugins_folder/zsh-autopair
  clone_if_not_exists 'https://github.com/b4b4r07/enhancd.git' $zsh_plugins_folder/enhancd
  clone_if_not_exists 'https://github.com/zdharma/fast-syntax-highlighting' $zsh_plugins_folder/fast-syntax-highlighting
  clone_if_not_exists 'https://github.com/wfxr/forgit.git' $zsh_plugins_folder/forgit
  clone_if_not_exists 'https://github.com/supercrabtree/k.git' $zsh_plugins_folder/k
  clone_if_not_exists 'https://github.com/qoomon/zjump.git' $zsh_plugins_folder/zjump
  clone_if_not_exists 'https://github.com/robbyrussell/oh-my-zsh.git' $zsh_plugins_folder/oh-my-zsh
  clone_if_not_exists 'https://github.com/zsh-users/zsh-history-substring-search.git' $zsh_plugins_folder/zsh-history-substring-search
  if ! [ -f '/etc/os-release' ] || ! [[ $(cat /etc/os-release) =~ 'Raspbian' ]]; then
  clone_if_not_exists 'https://github.com/zsh-users/zsh-autosuggestions.git' $zsh_plugins_folder/zsh-autosuggestions
  fi
}

function install_tools_from_custom_scripts() {
  echo "Linking installers for ${tools_folder}..."
  for installer in `find "$tools_folder" -name '*install*' -maxdepth 2 -type f`
  do
    installer_name="${installer%/*}"
    installer_name="${installer_name##*/}"
    if [[ "$installer" =~ uninstall ]]
    then
      make_link "$installer" "$user_bin/${uninstall_prefix}${installer_name}"
    else
      make_link "$installer" "$user_bin/${install_prefix}${installer_name}"
    fi
  done

  echo 'Linking done...'
}


install_tools_from_custom_scripts
echo 'Configs:'
echo "Install git [$in_install_git]"
echo "Install vim [$in_install_vim]"
echo "Install neovim [$in_install_nvim]"
echo "Install zsh [$in_install_zsh]"
echo "Install zsh plugins [$in_install_zsh_plugins]"
echo "Install generate brewfile [$in_generate_brewfile]"
echo "Install ctags [$in_config_ctags]"

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
misc_files_tolink[0]='runcom/.custom_profile'

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
if [[ "$in_install_rust" == 'yes' ]]; then
  curr=$(pwd)
  cd tools/rustup
  ./install.sh
  cd ../exa
  ./install.sh
  cd ../bat
  ./install.sh
  cd "$curr"
fi

install_vim_plugins "$in_install_vim"
setup_neovim_config "$in_install_nvim"
install_fzf "$in_install_fzf" "$in_fzf_version"
install_zsh_plugins "$in_install_zsh_plugins" "$zsh_plugins_folder"
generate_brewfile "$in_generate_brewfile"

# ==================================================
# Shutdown
# ==================================================
echo 'Be sure to checkout:'
echo ' - https://github.com/ryanoasis/nerd-fonts'
echo ' - https://github.com/so-fancy/diff-so-fancy'

echo 'All done!'
