#!/usr/bin/env bash

function print_help () {
  echo 'Usage: ./install.sh [options]'
  echo ' '
  echo 'Options:'
  echo '  -t, --tool the tool to install. Example "-t vim"'
  echo '  -u, --uninstall uninstall something or everything'
  echo '  -v, --verbose print every command. Same as set -x'
  echo '  -y, --no-prompt say yes to everything and automate as much as possible'
  echo '  -h, --help print this help menu'
  echo '  --user the user name to use to install and for folder finding. Useful when running as root but setting up for some other user'
  echo '  --home the home of the dotfiles folder. Every folder or file created will be relative to this'
  echo ' '
  echo 'Notes:'
  echo ' '
  echo '  - During installation tools can be opt out by prefixing "--no-" to the tool name. Example: "./install --no-vim" will install everything except vim'
}

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --fzf-version)
      # TODO should use here the same approach as with the --no-* flags
      fzf_version="$2"
      shift 2
      ;;
    --user)
      user="$2"
      shift 2
      ;;
    --home)
      user_home="$2"
      shift 2
      ;;
    -u|--uninstall)
      uninstall=1
      shift
      ;;
    -t|--tool|--tools)
      tool="$2"
      shift 2
      ;;
    --no-*)
      name="${1##*-}"
      export "DOTFILES_REQUESTED_TO_SKIP_${name^^}"=0
      shift
      ;;
    -v|--verbose)
      verbose=1
      shift
      ;;
    -y)
      export DOTFILES_PROMPT=0
      shift
      ;;
    -h|--help)
      print_help
      exit 0
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

# Expose env variables with all tools that are meant to be skipped
printf 'Tools requested to skip:\n'
while IFS='=' read -r name value ; do
  if [[ $name == *'DOTFILES_REQUESTED_TO_SKIP'*  ]]; then
    printf '  - %s\n' "${name##*_}"
  fi
done < <(env)

if [ -n "$user_home" ]; then
  echo "Setting dotfiles user home to $user_home"
  export DOTFILES_USER="$user"
  export DOTFILES_USER_HOME="$user_home"
fi

. common.sh
. funcs.sh

find-os

touch-dotfiles
action='install'
if ((${uninstall:-0})); then
  action='uninstall'
fi

if [ -n "$fzf_version" ]; then
  export DOTFILES_FZF_VERSION="$fzf_version"
fi

function evaluate-tool-file () {
  tool="$1"
  action="$2"
  file_to_eval="tools/$tool/$action.sh"

  set +e
  eval "$file_to_eval $tool"
  set -e

  # shellcheck disable=SC2181
  if [[ "$?" != 0 ]]; then
    echo "__FAIL: $tool"
  fi

}
# ==================================================
# Check single tool?
# ==================================================
if [ -n "$tool" ]; then
  # when installing a single tool we make copies of the configs
  # because only a subset of them will be overwritten.
  # In or not to lose the configs of the tools we won't install,
  # we back then up first
  copy-dotfiles-configs
  evaluate-tool-file "$tool" "$action"
  echo "Finished $action $tool"

  if ! (("${uninstall:-0}")); then
    cleanup
  fi
  exit 0
fi
# ==================================================
# Make links
# ==================================================
echo 'Creating links...'
create-link-at-home 'runcom/.custom_profile'
create-link-at-home 'runcom/.bash_profile'
# ==================================================
# Package managers
# ==================================================
echo 'Installing package managers...'
install-tool 'curl'
install-tool 'rustup'
install-tool 'sdkman'
install-tool 'go'
# ==================================================
# Tools
# ==================================================
echo 'Installing tools...'

a=0
for t in tools/* ; do
  toolname="${t##*/}"
  evaluate-tool-file "$toolname" "$action"
  a+=1
  if [[ $a == 3 ]]; then
    exit 0
  fi
done
cleanup
# ==================================================
# Shutdown
# ==================================================
echo 'Be sure to checkout:'
echo ' - https://github.com/ryanoasis/nerd-fonts'
echo ' - https://github.com/so-fancy/diff-so-fancy'
echo ' - Do C-x + i to install tpm inside tmux!'

echo 'All done!'
