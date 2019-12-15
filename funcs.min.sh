#!/usr/bin/env bash

function touch-dotfiles () {
  echo 'boo'
  touch -a "${DOTFILES_FULL_PATH:?}/$DOTFILES_ALIAS_FILE"
  touch -a "${DOTFILES_FULL_PATH:?}/$DOTFILES_CONFIG_FILE"
  touch -a "${DOTFILES_FULL_PATH:?}/$DOTFILES_ENV_FILE"
  touch -a "${DOTFILES_FULL_PATH:?}/$DOTFILES_SOURCES_FILE"
}

function ask_yes_or_no () {
  question="$1"
  move_on_quietly=${2:-0}

  printf "$question [Y/n]: "
  read -r yesno
  yesno=${yesno,,}
  if [[ "${yesno:-y}" =~ ^(y|yes)$ ]] ; then
    if [[ $move_on_quietly != 0 ]] ; then
      echo 'Continuing...'
    fi
  else
    echo 'Aborting installation!'
    exit 0
  fi
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
  if [ -z "$DOTFILES_RESOLVED_OS" ] ; then
    find-os
  fi
  [[ "$DOTFILES_RESOLVED_OS" =~ $1 ]]
}

function is-macos () {
  [[ "$OSTYPE" =~ 'darwin' ]] || return 1
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
