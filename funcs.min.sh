#!/usr/bin/env bash

function shck_one () {
    shellcheck --external-sources --external-sources --format=tty --exclude=SC1090,1091 --shell=bash "$1"
}

function shck_dotfiles_recursive () {
  dir="$1"
  while IFS= read -r -d '' f
  do
    shck_one "$f"
  done <   <(find "$dir" -type f \( -name "*.sh" -or -name '*.alias' -or -name '*.functions' -or -name '*.env' \) -print0)
}

shck_dotfiles () {
  shck_dotfiles_recursive "$DOTFILES_FULL_PATH/tools"
  shck_one "$DOTFILES_FULL_PATH/install.sh"
  shck_one "$DOTFILES_FULL_PATH/func.sh"
  shck_one "$DOTFILES_FULL_PATH/func.min.sh"
}

# --leds_off({0 | 1}) {
leds_off () {
  if is-rpi ; then
    echo "$1" | sudo tee /sys/class/leds/led0/brightness
    echo "$1" | sudo tee /sys/class/leds/led1/brightness
  else
    echo 'Leds only controllable in RPI'
  fi
}

# --listfn([toolName = runcom/.functions]) {
listfn () {
  function_path="$HOME/dotfiles/tools"
  if [ -n "$1" ]
  then
    function_path="$function_path/$1"
  else
    function_path="$HOME/dotfiles/runcom"
  fi

  fname=$2
  # shellcheck disable=SC2044
  for f in $(find "$function_path" -name '*functions*' -maxdepth 2 -type f)
  do
    ag --no-numbers --no-filename --no-color -o "^# --(function\ )?\K(.*${fname}.*)(?=\{)" "$f"
  done
  echo '---'
}

# --print_cmd_exists(commandName) {
print_cmd_exists() {
  if command_exists "$1"
  then
    echo 'yes'
  else
    echo 'no'
  fi
}

mk() {
  mkdir -p "$1" && cd "$_" || exit 1
}

open_conns() {
  netstat -nat | awk '{print $6}' | sort | uniq -c | sort -n
}

command_exists() {
  type "$1" 1>/dev/null 2>/dev/null
}

cag() {
  if command_exists ag
  then
    ag "$1" --numbers --pager less --stats --nopager "${@:2}"
  else
    echo 'Ag not installed, visit: https://github.com/ggreer/the_silver_searcher'
  fi
}


function command_exists () {
  type "$1" 1>/dev/null 2>/dev/null
}

function touch-dotfiles () {
  echo 'boo'
  touch -a "${DOTFILES_FULL_PATH:?}/$DOTFILES_ALIAS_FILE"
  touch -a "${DOTFILES_FULL_PATH:?}/$DOTFILES_CONFIG_FILE"
  touch -a "${DOTFILES_FULL_PATH:?}/$DOTFILES_ENV_FILE"
  touch -a "${DOTFILES_FULL_PATH:?}/$DOTFILES_SOURCES_FILE"
}

function ask_yes_or_no () {
  question="$1"

  printf "$question [Y/n]: "
  read -r yesno
  yesno=${yesno,,}
  if ! [[ "${yesno:-y}" =~ ^(y|yes)$ ]] ; then
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
  if [ -z "$DOTFILES_RESOLVED_OS" ] ; then
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
    export DOTFILES_RESOLVED_OS="$os"
  fi
}
