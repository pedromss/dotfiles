#! /usr/bin/env bash

set -e
. runcom/.functions
. funcs.sh

logs_dir=logs

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --no-rust)
      in_install_rust=0
      shift
      ;;
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
source ./common.sh
mkdir -p $logs_dir
# ==================================================
# Make links
# ==================================================
create-link-at-home 'runcom/.custom_profile'
create-link-at-home 'runcom/.bash_profile'
# ==================================================
# Tools
# ==================================================
install-tool 'tmux'
install-tool 'entr'

if (( ${in_install_rust:-1} )) ; then
  install-tool 'rustup' "$@"
  install-tool 'exa' "$@"
  install-tool 'bat' "$@"
  install-tool 'mdcat' "$@"
fi

if (( ${in_install_golang:-1} )) ; then
  install-tool 'go' "$@"
  install-tool 'gomplate' "$@"
  install-tool 'vault' "$@"
fi
# ==================================================
# Shutdown
# ==================================================
echo 'Be sure to checkout:'
echo ' - https://github.com/ryanoasis/nerd-fonts'
echo ' - https://github.com/so-fancy/diff-so-fancy'

echo 'All done!'
