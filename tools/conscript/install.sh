#!/usr/bin/env bash

quarantine
skip-if-os-is 'rpi'
skip-if-installed 'cs'

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  conscript_version=${1:-'v0.5.0'}
  echo 'Installing conscript...'
  wget "https://raw.githubusercontent.com/foundweekends/conscript/${conscript_version}/setup.sh" -O - | sh
  echo 'Conscript installed. Try "cs --help"'
  export PATH="$CONSCRIPT_HOME/bin:$PATH"
fi
