#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/runcom/.functions"

function cleanup () {
  remove-duplicates-from-config-file
  remove-duplicates-from-alias-file
  remove-duplicates-from-env-file
  remove-duplicates-from-sources-file
  cleanup-dotfiles-config-file
  cleanup-dotfiles-alias-file
  cleanup-dotfiles-env-file
  cleanup-dotfiles-sources-file
  rm -rf "$DOTFILES_TOOLS_INSTALLATION_FOLDER"
}

function touch-dotfiles () {
  touch "$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_FILE"
  touch "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_FILE"
  touch "$DOTFILES_FULL_PATH/$DOTFILES_ENV_FILE"
  touch "$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_FILE"

  mv "$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_NEW_FILE"
  mv "$DOTFILES_FULL_PATH/$DOTFILES_ENV_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_ENV_NEW_FILE"
  mv "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE"
  mv "$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_NEW_FILE"
}

function save-source () {
  filename="$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_NEW_FILE"
  echo ". $1" >> "$filename"
}

function save-alias () {
  filename="$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_NEW_FILE"
  alias "$1"="$2"
  echo "alias $1='$2'" >> "$filename"
}

function save-env () {
  filename="$DOTFILES_FULL_PATH/$DOTFILES_ENV_NEW_FILE"
  export "$1"="$2"
  echo "export $1=$2" >> "$filename"
}

function save-config () {
  filename="$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE"
  export "$1"="$2"
  echo "export $1=$2" >> "$filename"
}

function cleanup-dotfiles-sources-file () {
  mv "$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_NEW_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_FILE"
}

function cleanup-dotfiles-config-file () {
  mv "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_FILE"
}

function cleanup-dotfiles-env-file() {
  mv "$DOTFILES_FULL_PATH/$DOTFILES_ENV_NEW_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_ENV_FILE"
}

function cleanup-dotfiles-alias-file () {
  mv "$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_NEW_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_FILE"
}

function remove-duplicates-from-file () {
  if ! [ -f "$1" ]; then
    return
  fi
  uniq "$1" >> "$1.tmp"
  mv "$1.tmp" "$1"
}

function remove-duplicates-from-sources-file () {
  remove-duplicates-from-file "$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_NEW_FILE"
}

function remove-duplicates-from-config-file () {
  remove-duplicates-from-file "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE"
}

function remove-duplicates-from-env-file() {
  remove-duplicates-from-file "$DOTFILES_FULL_PATH/$DOTFILES_ENV_NEW_FILE"
}

function remove-duplicates-from-alias-file() {
  remove-duplicates-from-file "$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_NEW_FILE"
}

function make_link () {
  ln -sfv "$1" "$2"
}

function create-link-at-home () {
  create-nest-at-home "$1" ''
}

function create-nest-at-home() {
  # shellcheck disable=SC2154
  make_link "$DOTFILES_FULL_PATH/$1" "${DOTFILES_USER_HOME}$2"
}

function create-tool-link-at-home() {
  create-link-at-home "tools/$1"
}

function rm-link-at-home () {
  rm -f "$DOTFILES_USER/$1"
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
  folder="$DOTFILES_TOOLS_INSTALLATION_FOLDER/$toolname"
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
  folder="$DOTFILES_TOOLS_INSTALLATION_FOLDER/entr"
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

    log_file="dotfiles-$tool.log"
    if ! [ -f 'install.sh' ]; then
      echo "tool $tool: no install file present"
    else
	set +e
      ./install.sh "$@"
      set -e
      if [[ $? != 0 ]]; then
	      echo "FAILED installing $exa"
      fi
    fi
  fi
  cd "$curr" || exit
}

