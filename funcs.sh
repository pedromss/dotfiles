#!/usr/bin/env bash

function source_recursive() {
  dir="$1"
  if ! [ -d "$dir" ]
  then
    return
  fi

  current=$(pwd)
  for x in `find $dir -maxdepth 1 -mindepth 1 -type d`
  do
    if [[ "$x" != "$current" ]]
    then
      source_for_command "$x"
    fi
  done
}

function source_for_command() {
  cmd="${1##*/}"

  # Env files will always be sourced in the hopes that they
  # don't hurt anyone
  for f in `find $1 -name ".env.source" -type f`
  do
    source "$f"
  done

  if command_exists "$cmd"
  then
    for f in `find $1 \( -not -name '.env.source' -a -name '.*.source' \) -type f`
    do
      source "$f"
    done
  fi
}

function make_link () {
  ln -sfv $1 $2
}

function create-link-at-home () {
  make_link "$dotfiles_fullpath/$1" "$user_home"
}

function create-tool-link-at-home() {
  create-link-at-home "tools/$1"
}

function rm-link-at-home () {
rm -f "$user_home/$1"
}

function clone-from-github () {
  skip-if-dir-exists "$1" "$2"
  git clone --depth 1 "https://github.com/$1" $2
}

function is-macos () {
  [[ "$OSTYPE" =~ 'darwin' ]] || return 1
}

function skip-if-requested () {
  (( ${2:-0} )) && { echo "skipping: [$2] - requested to skip"; exit 0; }
}

function skip-if-installed () {
  ! command_exists "$1" || { echo "skipping: [$1] - already installed!"; exit 0; }
}

function skip-if-dir-exists () {
  ! [ -d "$2" ] || { echo "skipping: [$1] - already installed!"; exit 0; }
}

function skip-if-not-installed () {
  command_exists "$1" || { echo "skipping: [$1] - not installed"; exit 0; }
}

function require-tool () {
  command_exists "$1" || { echo "$1 is required"; exit 1; }
}

function require-tool-to-install () {
  command_exists "$1" || { echo "$1 is required to install $2"; exit 1; }
}

function require-dir () {
  [ -d "$1" ] || { echo "$1 should be a directory"; exit 1; }
}

function require-file () {
  [ -f "$1" ] || { echo "$1 is required"; exit 1; }
}

function install-with-pkg-manager () {
  if is-macos ; then
    require-tool 'brew'
    brew install "$1"
  else
    # assume apt-get
    sudo apt-get install "$1"
  fi
}

function uninstall-with-pkg-manager () {
  if is-macos ; then
    require-tool 'brew'
    brew uninstall "$1"
  else
    # assume apt-get
    sudo apt-get remove "$1"
  fi
}

function toolname-from-git-repo-http-url() {
  toolname="${1##*/}"
  toolname="${toolname%%.git}"
}

function toolname-from-pwd () {
  toolname=$(pwd)
  toolname=${toolname##*/}
}

function uninstall-tool-from-git-repo() {
  require-tool 'git'
  toolname-from-git-repo-http-url "$1"
  curr=$(pwd)
  folder="$tools_install_folder/$toolname"
  cd "$folder"
  eval $2
  cd "$curr"
  rm -rf "$folder"
}

# --function install-tool-from-git-repo (gitrepo, git tag, commands to install) {
function install-tool-from-git-repo () {
  require-tool 'git'
  curr=$(pwd)
  toolname="${1##*/}"
  toolname="${toolname%%.git}"
  folder="$tools_install_folder/entr"
  if ! [ -d "$folder" ]; then
    git clone --depth 1 "$1" "$folder"
  fi
  cd "$folder"
  git fetch -q --tags
  echo "Checking out $2..."
  git checkout -q "$2"

  echo "Installing..."
  eval "$3"

  echo "Installed $toolname!"
  cd "$curr"
}

function install-tool () {
  curr=$(pwd)
  tool="$1"
  shift
  if ! [ -d "tools/$tool" ]; then
    echo "skipping: $tool - not found!"
  else
    cd "tools/$tool"
    ./install.sh $@
  fi
  cd "$curr"
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
