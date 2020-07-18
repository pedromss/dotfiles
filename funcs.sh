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

