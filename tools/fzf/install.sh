#!/usr/bin/env bash

fzf_version='0.18.0'
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --fzf-version)
      fzf_version=$2
      shift 2
      ;;
    --no-fzf)
      install_fzf=0
      shift
      ;;
    --verbose)
      verbose=1
      shift
      ;;
    --main-device)
      main_device=1
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

skip-if-requested 'fzf' $install_fzf
skip-if-dir-exists 'fzf' "$HOME/.fzf"
require-tool-to-install 'git' 'fzf'

fzf_version="$2"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
echo "Installing fzf@$fzf_version"
cd ~/.fzf && git fetch --tags 1>/dev/null && git checkout $fzf_version
~/.fzf/install --key-bindings --completion --update-rc --no-fish
