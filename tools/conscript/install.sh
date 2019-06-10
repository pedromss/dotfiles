#!/usr/bin/env bash

function install_conscript() {
  if command_exists cs
  then
    echo 'Conscript already installed. Skipping!'
    exit 0
  fi

  conscript_version=${1:-'v0.5.0'}
  echo 'Installing conscript...'
  wget "https://raw.githubusercontent.com/foundweekends/conscript/${conscript_version}/setup.sh" -O - | sh
}
