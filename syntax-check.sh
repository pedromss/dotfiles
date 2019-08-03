#!/usr/bin/env bash

. funcs.sh

function check-recursive() {
  while IFS= read -r -d '' f
  do
    shellcheck --external-sources --check-sourced --format=tty --exclude=SC1090,1091 --shell=bash "$f"
  done <   <(find "$1" -type f \( -name "$2" -or -name '*.alia' -or -name '*.source' \) -print0)
}

require-tool 'shellcheck'
check-recursive '.' '*.sh'
check-recursive 'runcom' '*'

