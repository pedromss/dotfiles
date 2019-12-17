#!/usr/bin/env bash

. ./funcs.min.sh

tools_to_install=()

function print_help () {
  echo 'Usage: ./install.sh [options]'
  echo ' '
  echo 'Options:'
  echo '  -t, --tool the tool to install. Example "-t vim"'
  echo '  -u, --uninstall uninstall something or everything'
  echo '  -v, --verbose print every command. Same as set -x'
  echo '  -y, --no-prompt say yes to everything and automate as much as possible'
  echo '  -h, --help print this help menu'
  echo '  --folder the name of the dotfiles folder. Defaults to [dotfiles]'
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
    #--fzf-version)
      ## TODO should use here the same approach as with the --no-* flags
      #fzf_version="$2"
      #shift 2
      #;;
    --lite)
      lite=1
      shift 2
      ;;
    --folder)
      dotfiles_folder="$2"
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
      export DOTFILES_VERBOSE=1
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

function evaluate-tool-file () {
  tool="$1"
  action="$2"
  file_to_eval="tools/$tool/$action.sh"
  eval "$file_to_eval $tool"

  # shellcheck disable=SC2181
  if [[ "$?" != 0 ]]; then
    echo "__FAIL: $tool"
  fi
}

function resolve_if_installing_or_uninstalling () {
  action='install'
  if ((${uninstall:-0})); then
    action='uninstall'
  fi
}

function check_which_tools_should_be_skipped () {
  # Expose env variables with all tools that are meant to be skipped
  echo 'Tools requested to skip:'
  while IFS='=' read -r name value ; do
    if [[ $name == *'DOTFILES_REQUESTED_TO_SKIP'*  ]] ; then
      printf '  - %s\n' "${name##*_}"
    fi
  done < <(env)
}

(( ${verbose:-0} )) && set -x

set -- "$@" "${POSITIONAL[@]}"

if [ -z "$user" ] ; then
  user=$(id -u -n)
fi

if [ -z "$user_home" ]; then
  user_home="${HOME:?}"
fi

export DOTFILES_USER="$user"
export DOTFILES_USER_HOME="$user_home"
export DOTFILES_FOLDER="${dotfiles_folder:-dotfiles}"
export DOTFILES_FULL_PATH="${DOTFILES_USER_HOME:?}/$DOTFILES_FOLDER"
mkdir -p "$DOTFILES_FULL_PATH"

echo 'Installing with:'
echo "  user: $DOTFILES_USER"
echo "  home: $DOTFILES_USER_HOME"

. common.sh
. funcs.sh

function scan_all_tools () {
  for f in `find "$DOTFILES_FULL_PATH/tools" -type f -name install.sh` ; do
    name="${f%*/install.sh}" # remove /install.sh
    name="${name##*/}" # remove the path, leaving only the tool name
    tools_to_install+=($name)
  done

  for n in "${tools_to_install[@]}" ; do
    echo "$n"
  done
}


prompt_for_continue
scan_all_tools
check_which_tools_should_be_skipped
prompt_for_continue
remove_tools_to_skip
prompt_for_continue
find-os
prompt_for_continue

#if [ -n "$fzf_version" ]; then
#export DOTFILES_FZF_VERSION="$fzf_version"
#fi

# ==================================================
# Check single tool?
# ==================================================
function check_if_single_tool () {

  # TODO WE ARE HERE. UNDERSTANDING THE COPY-DOTFILES-CONFIGS REASON


  if [ -n "$tool" ]; then
    # when installing a single tool we make copies of the configs
    # because only a subset of them will be overwritten.
    # In order not to lose the configs of the tools we won't install,
    # we back then up first
    copy-dotfiles-configs
    evaluate-tool-file "$tool" "$action"
    echo "Finished $action $tool"

    if ! (("${uninstall:-0}")); then
      cleanup
    fi
    exit 0
  fi
}
## ==================================================
## Make links
## ==================================================
#echo 'Creating links...'
#create-link-at-home 'runcom/.custom_profile'
#create-link-at-home 'runcom/.bash_profile'
## ==================================================
## Package managers
## ==================================================
#echo 'Installing package managers...'
#install-tool 'curl'
#install-tool 'rustup'
#install-tool 'sdkman'
#install-tool 'go'
## ==================================================
## Tools
## ==================================================
#echo 'Installing tools...'

#a=0
#for t in tools/* ; do
#toolname="${t##*/}"
#evaluate-tool-file "$toolname" "$action"
#a+=1
#if [[ $a == 3 ]]; then
#exit 0
#fi
#done
#cleanup
## ==================================================
## Shutdown
## ==================================================
#echo 'Be sure to checkout:'
#echo ' - https://github.com/ryanoasis/nerd-fonts'
#echo ' - https://github.com/so-fancy/diff-so-fancy'
#echo ' - Do C-x + i to install tpm inside tmux!'

#echo 'All done!'
