#! /usr/bin/env bash

set -e
. runcom/.functions
logs_dir=logs

in_username="$USER"
#in_install_git='yes'
#in_install_vim='yes'
#in_install_nvim='yes'
#in_install_zsh='yes'
#in_install_zsh_plugins='yes'
#in_config_ctags='yes'
#in_install_fzf='yes'
#in_fzf_version='0.18.0'
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --user)
      in_username=$2
      shift 2
      ;;
    --no-golang)
      in_install_golang=0
      shift
      ;;
    --no-rust)
      in_install_rust=0
      shift
      ;;
    --fzf-version)
      in_fzf_version=$2
      shift 2
      ;;
    --no-fzf)
      in_install_fzf=0
      shift
      ;;
    --no-zsh)
      in_install_zsh=0
      shift
      ;;
    --no-nvim)
      in_install_nvim=0
      shift
      ;;
    --no-zsh-plugins)
      in_install_zsh_plugins=0
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

function clone-from-github () {
  skip-if-dir-exists "$1" "$2"
  git clone --depth 1 "https://github.com/$1" $2
}

function install_vim_plugins() {
  require-tool 'vim'
  vim -c +PlugInstall +qall 
}

function install_fzf() {
  skip-if-requested 'fzf' $in_install_fzf
  skip-if-dir-exists 'fzf' "$HOME/.fzf"
  require-tool-to-install 'git' 'fzf'

  fzf_version="$2"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  echo "Installing fzf@$fzf_version"
  cd ~/.fzf && git fetch --tags 1>/dev/null && git checkout $fzf_version
  ~/.fzf/install --key-bindings --completion --update-rc --no-fish
}

function setup_neovim_config() {
  skip-if-requested 'nvim' $in_install_nvim
  mkdir -p "$XDG_CONFIG_HOME/nvim"
  mkdir -p "$XDG_DATA_HOME/nvim"

  # TODO probably shouldn't link these to dotfiles as they are specific to each host
  make_link "$dotfiles_fullpath/.local/share/nvim" $XDG_DATA_HOME/nvim
  make_link "$dotfiles_fullpath/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim"
}

function install_zsh_plugins() {
  skip-if-requested 'zsh-plugins' $in_install_zsh_plugins

  mkdir -p "$1"

  clone-from-github 'Cloudstek/zsh-plugin-appup.git' $zsh_plugins_folder/appup
  clone-from-github 'hlissner/zsh-autopair.git' $zsh_plugins_folder/zsh-autopair
  clone-from-github 'b4b4r07/enhancd.git' $zsh_plugins_folder/enhancd
  clone-from-github 'zdharma/fast-syntax-highlighting' $zsh_plugins_folder/fast-syntax-highlighting
  clone-from-github 'wfxr/forgit.git' $zsh_plugins_folder/forgit
  clone-from-github 'supercrabtree/k.git' $zsh_plugins_folder/k
  clone-from-github 'qoomon/zjump.git' $zsh_plugins_folder/zjump
  clone-from-github 'robbyrussell/oh-my-zsh.git' $zsh_plugins_folder/oh-my-zsh
  clone-from-github 'zsh-users/zsh-history-substring-search.git' $zsh_plugins_folder/zsh-history-substring-search
  if ! [ -f '/etc/os-release' ] || ! [[ $(cat /etc/os-release) =~ 'Raspbian' ]]; then
    clone-from-github 'zsh-users/zsh-autosuggestions.git' $zsh_plugins_folder/zsh-autosuggestions
  fi
}

# ==================================================
# Files to link
# ==================================================
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
create-link-at-home 'runcom/.custom_profile'
create-link-at-home 'runcom/.bash_profile'
# ==================================================
# Tools
# ==================================================
install-toolset \
  tmux \
  entr

if (( ${in_install_rust:-1} )) ; then
  install-toolset \
    rustup \
    exa \
    bat \
    mdcat
fi

if (( ${in_install_golang:-1} )) ; then
  install-toolset \
    go \
    gomplate \
    vault
  fi

  install_vim_plugins 
  setup_neovim_config 
  install_fzf "$in_fzf_version"
  install_zsh_plugins "$zsh_plugins_folder"
  generate_brewfile

# ==================================================
# Shutdown
# ==================================================
echo 'Be sure to checkout:'
echo ' - https://github.com/ryanoasis/nerd-fonts'
echo ' - https://github.com/so-fancy/diff-so-fancy'

echo 'All done!'
