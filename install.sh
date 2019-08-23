#! /usr/bin/env bash

set -e
. runcom/.functions

logs_dir=logs

while [[ $# -gt 0 ]]
do
  key="$1" 
  case $key in
    -u|--uninstall)
      uninstall=1
      shift
      ;;
    -t|--tool|--tools)
      tool="$2"
      shift 2
      ;;
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
. common.sh
. funcs.sh
touch-dotfiles
# ==================================================
# Check single tool?
# ==================================================
if [ -n "$tool" ]; then
  action='install'
  if ((${uninstall:-0})); then
    action='uninstall'
  fi

  file_to_eval="tools/$tool/$action.sh"
  (( ${verbose:-0} )) && set -x
  set +e
  eval "$file_to_eval $*"
  set -e
  if [[ "$?" != 0 ]]; then
    echo "__FAIL: $tool"
  else
    echo "Finished $action $tool"
  fi

  if ! (("${uninstall:-0}")); then
    cleanup
  fi
  exit 0
fi
# ==================================================
# Make links
# ==================================================
create-link-at-home 'runcom/.custom_profile'
create-link-at-home 'runcom/.bash_profile'
# ==================================================
# Tools
# ==================================================
#install-tool 'java'
install-tool 'tpm'
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
cleanup
# ==================================================
# Shutdown
# ==================================================
echo 'Be sure to checkout:'
echo ' - https://github.com/ryanoasis/nerd-fonts'
echo ' - https://github.com/so-fancy/diff-so-fancy'

echo 'All done!'
