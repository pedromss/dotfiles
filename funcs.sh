#!/usr/bin/env bash

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

function install_with_pkg_manager () {
  tool="${1:-$DOTFILES_CURRENT_TOOL}"

  set +e
  if is_macos ; then
    brew install "$tool"
  elif is_debian ; then
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

# TODO should probably delete this and make things explicit
# --function install-tool-from-git-repo (gitrepo, git tag, commands to install) {
function install_tool_from_git_repo () {
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

function install_tool () {
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

function install_with_npm () {
  tool="${1:-$DOTFILES_CURRENT_TOOL}"
  npm install -g --save-dev "$tool"
}

function install_with_pip () {
  tool="${1:-$DOTFILES_CURRENT_TOOL}"
  pip install "$tool"
}

function install_with_sdkman () {
  sdk install "$1" "$2"
}

function install_with_cargo () {
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

function get_name_of_tool_from_path () {
  dir=$(dirname "$0")
  export DOTFILES_CURRENT_TOOL="${dir##*/}"
}

function download_tarball_to () {
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
  remove_duplicates_from_config_file
  remove_duplicates_from_alias_file
  remove_duplicates_from_env_file
  remove_duplicates_from_sources_file
  cleanup_dotfiles_config_file
  cleanup_dotfiles_alias_file
  cleanup_dotfiles_env_file
  cleanup_dotfiles_sources_file
}

function only_if_os_is () {
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

function copy_dotfiles_configs () {
  cp "$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_NEW_FILE"
  cp "$DOTFILES_FULL_PATH/$DOTFILES_ENV_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_ENV_NEW_FILE"
  cp "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE"
  cp "$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_FILE" "$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_NEW_FILE"
}

function save_env () {
  #echo "NEED TO FIX save_env"
  return
}

function save_source () {
  #echo "NEED TO FIX save_source"
  return
  #filename="$DOTFILES_FULL_PATH/$DOTFILES_SOURCES_NEW_FILE"
  #echo ". $1 2>/dev/null" >> "$filename"
}

function save_alias () {
  #echo "NEED TO FIX save_alias"
  return
  #filename="$DOTFILES_FULL_PATH/$DOTFILES_ALIAS_NEW_FILE"
  ## shellcheck disable=SC2139
  #alias "$1"="$2"
  #echo "alias $1='$2'" >> "$filename"
}

function save_config () {
  return
  #filename="$DOTFILES_FULL_PATH/$DOTFILES_CONFIG_NEW_FILE"
  #export "$1"="$2"
  #echo "export $1=$2" >> "$filename"
}

function move_in_dotfiles () {
  file="${DOTFILES_FULL_PATH:?}/$1"
  if [ -f "$file" ]; then
    mv "$file" "${DOTFILES_FULL_PATH:?}/$2"
  fi
}

function cleanup_dotfiles_sources_file () {
  move_in_dotfiles "$DOTFILES_SOURCES_NEW_FILE" "$DOTFILES_SOURCES_FILE"
}

function cleanup_dotfiles_config_file () {
  move_in_dotfiles "$DOTFILES_CONFIG_NEW_FILE" "$DOTFILES_CONFIG_FILE"
}

function cleanup_dotfiles_env_file() {
  move_in_dotfiles "$DOTFILES_ENV_NEW_FILE" "$DOTFILES_ENV_FILE"
}

function cleanup_dotfiles_alias_file () {
  move_in_dotfiles "$DOTFILES_ALIAS_NEW_FILE" "$DOTFILES_ALIAS_FILE"
}

function remove_duplicates_from_file () {
  if ! [ -f "$1" ]; then
    return
  fi
  uniq "$1" >> "$1.tmp"
  mv "$1.tmp" "$1"
}

function remove_duplicates_from_sources_file () {
  remove_duplicates_from_file "${DOTFILES_FULL_PATH:?}/$DOTFILES_SOURCES_NEW_FILE"
}

function remove_duplicates_from_config_file () {
  remove_duplicates_from_file "${DOTFILES_FULL_PATH:?}/$DOTFILES_CONFIG_NEW_FILE"
}

function remove_duplicates_from_env_file() {
  remove_duplicates_from_file "${DOTFILES_FULL_PATH:?}/$DOTFILES_ENV_NEW_FILE"
}

function remove_duplicates_from_alias_file() {
  remove_duplicates_from_file "${DOTFILES_FULL_PATH:?}/$DOTFILES_ALIAS_NEW_FILE"
}

function make_link () {
  ln -sfv "$1" "$2"
}

function create_link_at_home () {
  create_nest_at_home "$1" ''
}

function destroy_at_home () {
  rm -rf "$DOTFILES_USER_HOME/$1"
}

function create_nest_at_home() {
  # shellcheck disable=SC2154
  make_link "${DOTFILES_FULL_PATH:?}/$1" "${DOTFILES_USER_HOME}$2"
}

function create_tool_link_at_home() {
  create_link_at_home "tools/$1"
}

function rm_link_at_home () {
  rm -f "${DOTFILES_USER:?}/$1"
}

function clone_from_github () {
  if ! [ -d "$2" ] ; then
    git clone --depth 1 "https://github.com/$1" "$2"
  fi
}

function skip_if_tool_is_not_installed () {
  command_exists "$1" || { echo " ---> skipping: [$2] because [$1] is required for it"; exit 0; }
}

function skip_if_installed () {
  tool="${1:-$DOTFILES_CURRENT_TOOL}"
  if (( ${DOTFILES_UPDATE_RUN:-0} )) ; then
    DOTFILES_SHOULD_STOP_CURRENT=0
    return
  fi
  if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
    if command_exists "$tool" \
      || [ -d "$DOTFILES_BIN/$tool" ] \
      || [ -f "$DOTFILES_BIN/cargo/bin/$tool" ] ; then
      export DOTFILES_TOOL_ALREADY_INSTALLED=1
      export DOTFILES_SHOULD_STOP_CURRENT=1
    fi
  fi
}

function skip_if_dir_exists () {
  dir="$1"
  if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
    if [ -d "$dir" ]; then
      export DOTFILES_TOOL_ALREADY_INSTALLED=1
      export DOTFILES_SHOULD_STOP_CURRENT=1
    fi
  fi
}

function uninstall_with_pkg_manager () {
  if [ -z "$1" ]; then
    get_name_of_tool_from_path
    in_tool="${DOTFILES_CURRENT_TOOL}"
  else
    in_tool="$1"
  fi
  tool="$in_tool"

  set +e
  if is_macos ; then
    brew uninstall "$tool"
  elif is_debian ; then
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

function toolname_from_git_repo_http_url() {
  toolname="${1##*/}"
  toolname="${toolname%%.git}"
}

function toolname_from_pwd () {
  toolname=$(pwd)
  toolname=${toolname##*/}
}

function uninstall_tool_from_git_repo() {
  toolname_from_git_repo_http_url "$1"
  curr=$(pwd)
  # shellcheck disable=SC2154
  folder="$DOTFILES_TOOLS_INSTALLATION_FOLDER/$toolname"
  cd "$folder" || exit 1
  eval "$2"
  cd "$curr" || exit 1
  rm -rf "$folder"
}

