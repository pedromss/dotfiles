#!/usr/bin/env bash

# TODO should find a formatter for the skip print...

set +e
# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/common.sh" 2>/dev/null
# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/runcom/.functions" 2>/dev/null
# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/$DOTFILES_ALIAS_FILE" 2>/dev/null
# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/$DOTFILES_CONFIG_FILE" 2>/dev/null
# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/$DOTFILES_ENV_FILE" 2>/dev/null
# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/$DOTFILES_SOURCES_FILE" 2>/dev/null
set -e

function skip-if-tool-is-not-installed () {
  command_exists "$1" || { echo " ---> skipping: [$2] because [$1] is required for it"; exit 0; }
}

function install-with-sdkman () {
  sdk install "$1" "$2"
}

function install-with-cargo () {
  if [ -z "$1" ]; then
    get-name-of-tool-from-path
    in_tool="${DOTFILES_CURRENT_TOOL}"
  else
    in_tool="$1"
  fi
  tool="$in_tool"
  cargo install --force "$tool"
}

function skip-if-installed () {
  if [ -z "$1" ]; then
    get-name-of-tool-from-path
    in_tool="$DOTFILES_CURRENT_TOOL"
  else
    in_tool="$1"
  fi
  tool="$in_tool"
  ! command_exists "$tool" || { echo " ---> skipping: [$tool] - already installed!"; exit 0; }
}

function skip-if-requested () {
  if [ -z "$1" ]; then
    get-name-of-tool-from-path
    in_tool="${DOTFILES_CURRENT_TOOL}"
  else
    in_tool="$1"
  fi
  tool="${in_tool^^}"
  # shellcheck disable=SC2034
  while IFS='=' read -r name value ; do
    if [[ $name == "DOTFILES_REQUESTED_TO_SKIP_$tool"  ]]; then
      echo " ---> skipping: [$in_tool] as it was requested with --no-$in_tool flag"
      exit 0
    fi
  done < <(env)
}

function get-name-of-tool-from-path () {
  dir=$(dirname "$0")
  export DOTFILES_CURRENT_TOOL="${dir##*/}"
}

function download-tarball-to () {
  sudo wget -qO- "$1" | sudo tar xz -C "$2"
}

function cleanup () {
  remove-duplicates-from-config-file
  remove-duplicates-from-alias-file
  remove-duplicates-from-env-file
  remove-duplicates-from-sources-file
  cleanup-dotfiles-config-file
  cleanup-dotfiles-alias-file
  cleanup-dotfiles-env-file
  cleanup-dotfiles-sources-file
}

function touch-dotfiles () {
  touch -a "${DOTFILES_FULL_PATH:?}/$DOTFILES_ALIAS_FILE"
  touch -a "${DOTFILES_FULL_PATH:?}/$DOTFILES_CONFIG_FILE"
  touch -a "${DOTFILES_FULL_PATH:?}/$DOTFILES_ENV_FILE"
  touch -a "${DOTFILES_FULL_PATH:?}/$DOTFILES_SOURCES_FILE"
}

function skip-if-os-is () {
  tool="$1"
  os="$2"
  if [[ "$DOTFILES_RESOLVED_OS" =~ $os ]]; then
    echo " ---> skipping: [$tool] - not meant to be installed on $os"
    exit 0
  fi
}

function only-if-os-is () {
  if [ -z "$1" ]; then
    get-name-of-tool-from-path
    in_tool="${DOTFILES_CURRENT_TOOL}"
  else
    in_tool="$1"
  fi
  tool="$in_tool"
  os="$2"
  if ! [[ $DOTFILES_RESOLVED_OS =~ $os ]]; then
    echo " ---> skipping: [$tool] - only meant to be installed in $os"
    exit 0
  fi
}

function quarantine () {
  get-name-of-tool-from-path
  echo " ---> skipping: [${DOTFILES_CURRENT_TOOL}] is quarantined"
  exit 0
}

function copy-dotfiles-configs () {
  cp "$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_NEW_FILE"
  cp "$DOTFILES_FULL_PATH/$DOTFILES_ENV_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_ENV_NEW_FILE"
  cp "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE"
  cp "$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_NEW_FILE"
}

function is-rpi () {
  check-os 'rpi'
}

function is-linux () {
  check-os 'ubuntu|rpi'
}

function is-debian () {
  check-os 'ubuntu|rpi'
}

function is-ubuntu () {
  check-os 'ubuntu'
}

function is-unix () {
  check-os 'mac|ubuntu|rpi'
}

function check-os () {
  [[ "$DOTFILES_RESOLVED_OS" =~ $1 ]]
}

function find-os () {
  [ -z "$DOTFILES_RESOLVED_OS" ] || return
  supported_oses='mac, rpi, ubuntu'
  os=''
  if is-macos ; then
    os='mac'
  elif [ -f '/etc/os-release' ]; then
    os_release=$(cat /etc/os-release)
    if [[ "$os_release" =~ 'Raspbian' ]]; then
      os='rpi'
    elif [[ "$os_release" =~ 'Ubuntu' ]]; then
      os='ubuntu'
    fi
  else
    echo "__FAIL: unable to detect os. Should be one of: $supported_oses"
    read -r input_os
    os="$input_os"
  fi
  echo "Resolved OS is: [$os]"
  export DOTFILES_RESOLVED_OS="$os"
}

function save-source () {
  filename="$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_NEW_FILE"
  echo ". $1 2>/dev/null" >> "$filename"
}

function save-alias () {
  filename="$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_NEW_FILE"
  # shellcheck disable=SC2139
  alias "$1"="$2"
  echo "alias $1='$2'" >> "$filename"
}

function save-config () {
  filename="$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE"
  export "$1"="$2"
  echo "export $1=$2" >> "$filename"
}

function move-in-dotfiles () {
  file="${DOTFILES_FULL_PATH:?}/$1"
  if [ -f "$file" ]; then
    mv "$file" "${DOTFILES_FULL_PATH:?}/$2"
  fi
}

function cleanup-dotfiles-sources-file () {
  move-in-dotfiles "$DOTFILES_SOURCES_NEW_FILE" "$DOTFILES_SOURCES_FILE"
}

function cleanup-dotfiles-config-file () {
  move-in-dotfiles "$DOTFILES_CONFIG_NEW_FILE" "$DOTFILES_CONFIG_FILE"
}

function cleanup-dotfiles-env-file() {
  move-in-dotfiles "$DOTFILES_ENV_NEW_FILE" "$DOTFILES_ENV_FILE"
}

function cleanup-dotfiles-alias-file () {
  move-in-dotfiles "$DOTFILES_ALIAS_NEW_FILE" "$DOTFILES_ALIAS_FILE"
}

function remove-duplicates-from-file () {
  if ! [ -f "$1" ]; then
    return
  fi
  uniq "$1" >> "$1.tmp"
  mv "$1.tmp" "$1"
}

function remove-duplicates-from-sources-file () {
  remove-duplicates-from-file "${DOTFILES_FULL_PATH:?}/$DOTFILES_SOURCES_NEW_FILE"
}

function remove-duplicates-from-config-file () {
  remove-duplicates-from-file "${DOTFILES_FULL_PATH:?}/$DOTFILES_CONFIG_NEW_FILE"
}

function remove-duplicates-from-env-file() {
  remove-duplicates-from-file "${DOTFILES_FULL_PATH:?}/$DOTFILES_ENV_NEW_FILE"
}

function remove-duplicates-from-alias-file() {
  remove-duplicates-from-file "${DOTFILES_FULL_PATH:?}/$DOTFILES_ALIAS_NEW_FILE"
}

function make_link () {
  ln -sfv "$1" "$2"
}

function create-link-at-home () {
  create-nest-at-home "$1" ''
}

function destroy-at-home () {
  rm -rf "$DOTFILES_USER_HOME/$1"
}

function create-nest-at-home() {
  # shellcheck disable=SC2154
  make_link "${DOTFILES_FULL_PATH:?}/$1" "${DOTFILES_USER_HOME}$2"
}

function create-tool-link-at-home() {
  create-link-at-home "tools/$1"
}

function rm-link-at-home () {
  rm -f "${DOTFILES_USER:?}/$1"
}

function clone-from-github () {
  if ! [ -d "$2" ] ; then
    git clone --depth 1 "https://github.com/$1" "$2"
  else
    echo " ---> skipping: repo [$1] - already exists at $2"
  fi
}

function is-macos () {
  [[ "$OSTYPE" =~ 'darwin' ]] || return 1
}

function skip-if-dir-exists () {
  if [ -z "$1" ]; then
    get-name-of-tool-from-path
    in_tool="${DOTFILES_CURRENT_TOOL}"
  else
    in_tool="$1"
  fi
  tool="$in_tool"
  ! [ -d "$2" ] || { echo " ---> skipping: [$tool] - already installed!"; exit 0; }
}

function skip-if-not-installed () {
  command_exists "$1" || { echo " ---> skipping: [$1] - not installed"; exit 0; }
}

function require-tool () {
  command_exists "$1" || { echo "$1 is required"; exit 1; }
}

function require-tool-to-install () {
  get-name-of-tool-from-path
  tool="$DOTFILES_CURRENT_TOOL"
  command_exists "$1" || { echo "$1 is required to install $tool"; exit 1; }
}

function require-dir () {
  [ -d "$1" ] || { echo "$1 should be a directory"; exit 1; }
}

function require-file () {
  [ -f "$1" ] || { echo "$1 is required"; exit 1; }
}

function install-with-pkg-manager () {
  if [ -z "$1" ]; then
    get-name-of-tool-from-path
    in_tool="${DOTFILES_CURRENT_TOOL}"
  else
    in_tool="$1"
  fi
  tool="$in_tool"

  if is-macos ; then
    brew install "$tool"
  elif is-debian ; then
    sudo apt-get -y install "$tool"
  else
    echo 'Unable to resolve package manager'
    exit 1
  fi
}

function uninstall-with-pkg-manager () {
  if [ -z "$1" ]; then
    get-name-of-tool-from-path
    in_tool="${DOTFILES_CURRENT_TOOL}"
  else
    in_tool="$1"
  fi
  tool="$in_tool"

  if is-macos ; then
    brew uninstall "$tool"
  elif is-debian ; then
    sudo apt-get -y remove "$tool"
  else
    echo 'Unable to resolve package manager'
    exit 1
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
  toolname-from-git-repo-http-url "$1"
  curr=$(pwd)
  # shellcheck disable=SC2154
  folder="$DOTFILES_TOOLS_INSTALLATION_FOLDER/$toolname"
  cd "$folder" || exit 1
  eval "$2"
  cd "$curr" || exit 1
  rm -rf "$folder"
}

# TODO should probably delete this and make things explicit
# --function install-tool-from-git-repo (gitrepo, git tag, commands to install) {
function install-tool-from-git-repo () {
  curr=$(pwd)
  toolname="${1##*/}"
  toolname="${toolname%%.git}"
  folder="${DOTFILES_TOOLS_INSTALLATION_FOLDER:?}/$toolname"
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
    echo " ---> skipping: [$tool] - not found!"
  else
    cd "tools/$tool" || exit 1

    if ! [ -f 'install.sh' ]; then
      echo " ---> skipping: [$tool] - no install file present"
    else
      set +e
      ./install.sh "$tool"
      set -e
      # shellcheck disable=SC2181
      if [[ "$?" != 0 ]]; then
        echo "FAILED installing $tool"
      fi
    fi
  fi
  cd "$curr" || exit
}

