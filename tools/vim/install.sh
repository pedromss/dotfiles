#!/usr/bin/env bash

. ../../runcom/.functions
. ../../funcs.sh

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --verbose)
      verbose=1
      shift
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

(( ${verbose:-0} )) && set -x

set -- "$@" "${POSITIONAL[@]}"

create-link-at-home '.vim'
create-link-at-home 'ultisnips'
create-link-at-home '.vimrc'
create-link-at-home '.ideavim'
create-link-at-home '.ideavimrc'

skip-if-installed 'vim'

install-with-pkg-manager 'vim'
vim -c +PlugInstall +qall 

