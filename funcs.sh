#!/usr/bin/env bash

function install_with_npm () {
  tool="${1:-$DOTFILES_CURRENT_TOOL}"
  npm install -g --save-dev "$tool"
}

function update_github_repo () {
  git pull origin master
}

function check_is_root () {
  if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
    if ! [ "$(id -u)" -eq 0 ] ; then
      export DOTFILES_SUDO_REQUIRED=1
      export DOTFILES_SHOULD_STOP_CURRENT=1
    fi
  fi
}

function prompt_for_continue () {
  question='Continue?'
  if [[ $DOTFILES_PROMPT != 0 ]] ; then
    ask_yes_or_no "$question"
  fi
}

function skip-if-tool-is-not-installed () {
  command_exists "$1" || { echo " ---> skipping: [$2] because [$1] is required for it"; exit 0; }
}

function install_with_pip () {
  tool="${1:-$DOTFILES_CURRENT_TOOL}"
  pip install "$tool"
}

function install-with-sdkman () {
  sdk install "$1" "$2"
}

function install-with-cargo () {
  tool="${1:-$DOTFILES_CURRENT_TOOL}"
  cargo install --force "$tool"
}

function depends_on () {
  tool="$1"
  if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
    if ! command_exists "$tool" ; then
      export DOTFILES_DEPENDENCY_MISSING=1
      export DOTFILES_REQUIRED_DEPENDENCY="$tool"
      export DOTFILES_SHOULD_STOP_CURRENT=1
    fi
  fi
}

function skip-if-installed () {
  tool="${1:-$DOTFILES_CURRENT_TOOL}"
  if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
    if command_exists "$tool" \
      || [ -d "$DOTFILES_BIN/$tool" ] \
      || [ -f "$DOTFILES_BIN/cargo/bin/$tool" ] ; then
      export DOTFILES_TOOL_ALREADY_INSTALLED=1
      export DOTFILES_SHOULD_STOP_CURRENT=1
    fi
  fi
}

function get-name-of-tool-from-path () {
  dir=$(dirname "$0")
  export DOTFILES_CURRENT_TOOL="${dir##*/}"
}

function download-tarball-to () {
  curr=$(pwd)
  wget -q "$1"
  tarball_name="${1##*/}"
  mkdir -p "$2"
  mv "$tarball_name" "$2"
  cd "$2"
  tar -xf "$tarball_name"
  rm -f "$tarball_name"
  cd "$curr"
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

function skip-if-os-is () {
  os="$1"
  if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
    if [[ "$DOTFILES_RESOLVED_OS" =~ $os ]]; then
      export DOTFILES_TOOL_NOT_MEANT_FOR_OS=1
      export DOTFILES_SHOULD_STOP_CURRENT=1
    fi
  fi
}

function only-if-os-is () {
  os="$1"
  if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
    if ! [[ $DOTFILES_RESOLVED_OS =~ $os ]]; then
      export DOTFILES_TOOL_NOT_COMPATIBLE_WITH_OS=1
      export DOTFILES_SHOULD_STOP_CURRENT=1
    fi
  fi
}

function quarantine () {
  if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
    export DOTFILES_TOOL_QUARANTINED=1
    export DOTFILES_SHOULD_STOP_CURRENT=1
  fi
}

function copy-dotfiles-configs () {
  cp "$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_NEW_FILE"
  cp "$DOTFILES_FULL_PATH/$DOTFILES_ENV_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_ENV_NEW_FILE"
  cp "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE"
  cp "$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_NEW_FILE"
}

function save-env () {
  #echo "NEED TO FIX save-env"
  return
}

function save-source () {
  #echo "NEED TO FIX save-source"
  return
  #filename="$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_NEW_FILE"
  #echo ". $1 2>/dev/null" >> "$filename"
}

function save-alias () {
  #echo "NEED TO FIX save-alias"
  return
  #filename="$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_NEW_FILE"
  ## shellcheck disable=SC2139
  #alias "$1"="$2"
  #echo "alias $1='$2'" >> "$filename"
}

function save-config () {
  return
  #filename="$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE"
  #export "$1"="$2"
  #echo "export $1=$2" >> "$filename"
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
  fi
}

function skip-if-dir-exists () {
  dir="$1"
  if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
    if [ -d "$dir" ]; then
      export DOTFILES_TOOL_ALREADY_INSTALLED=1
      export DOTFILES_SHOULD_STOP_CURRENT=1
    fi
  fi
}

function install-with-pkg-manager () {
  tool="${1:-$DOTFILES_CURRENT_TOOL}"

  set +e
  if is-macos ; then
    brew install "$tool"
  elif is-debian ; then
    apt-get -y install "$tool"
    if [[ "$?" == 100 ]] ; then
      export DOTFILES_SUDO_REQUIRED=1
      export DOTFILES_SHOULD_STOP_CURRENT=1
      return
    fi
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

  set +e
  if is-macos ; then
    brew uninstall "$tool"
  elif is-debian ; then
    apt-get -y remove "$tool"
    if [[ $? == 100 ]] ; then
      export DOTFILES_SUDO_REQUIRED='requires sudo for "apt-get remove"'
      exit 0
    fi
  else
    echo 'Unable to resolve package manager'
    set -e
    exit 1
  fi
  set -e
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

