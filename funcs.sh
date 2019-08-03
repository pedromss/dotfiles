#!/usr/bin/env bash

. runcom/.functions

function save-config () {
  export "$1"="$2"
  echo "export $1=$2" >> "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE"
}

function cleanup-dotfiles-config-files () {
  mv "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_FILE"
}

function remove-duplicates-from-file () {
  uniq "$1" >> "$1.tmp"
  mv "$1.tmp" "$1"
}

function remove-duplicates-from-config-file () {
  remove-duplicates-from-file "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE"
}

function source_recursive() {
  dir="$1"
  if ! [ -d "$dir" ]
  then
    return
  fi

  current=$(pwd)
  # shellcheck disable=SC2044
  for x in $(find "$dir" -maxdepth 1 -mindepth 1 -type d)
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
  # shellcheck disable=SC2044
  for f in $(find "$1" -name ".env.source" -type f)
  do
    # shellcheck source=/dev/null
    source "$f"
  done

  if command_exists "$cmd"
  then
    # shellcheck disable=SC2044
    for f in $(find "$1" \( -not -name '.env.source' -a -name '.*.source' \) -type f)
    do
      # shellcheck source=/dev/null
      source "$f"
    done
  fi
}

function make_link () {
  ln -sfv "$1" "$2"
}

function create-link-at-home () {
  create-nest-at-home "$1" ''
}

function create-nest-at-home() {
  # shellcheck disable=SC2154
  make_link "$dotfiles_fullpath/$1" "${user_home}$2"
}

function create-tool-link-at-home() {
  create-link-at-home "tools/$1"
}

function rm-link-at-home () {
  rm -f "$user_home/$1"
}

function clone-from-github () {
  skip-if-dir-exists "$1" "$2"
  git clone --depth 1 "https://github.com/$1" "$2"
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
  # shellcheck disable=SC2154
  folder="$tools_install_folder/$toolname"
  cd "$folder" || exit 1
  eval "$2"
  cd "$curr" || exit 1
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
  cd "$folder" || exit 1
  git fetch -q --tags
  echo "Checking out $2..."
  git checkout -q "$2"

  echo "Installing..."
  eval "$3"

  echo "Installed $toolname!"
  cd "$curr" || exit 1
}

function install-tool () {
  curr=$(pwd)
  tool="$1"
  shift
  if ! [ -d "tools/$tool" ]; then
    echo "skipping: $tool - not found!"
  else
    cd "tools/$tool" || exit 1
    ./install.sh "$@"
  fi
  cd "$curr" || exit
}

