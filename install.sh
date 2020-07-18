#!/usr/bin/env bash

. funcs.min.sh

all_tools=()
tools_to_install=()
tools_to_skip=()
tools_requested=()
tool_log_suffix='.log'

tools_not_meant_for_os=()
tools_failed=()
tools_sudo_required=()
tools_quarantined=()
tools_already_installed=()

export DOTFILES_PROMPT=1
export DOTFILES_SHOW_PROGRESS=0
export DOTFILES_TOOL_PACKAGE_MANAGER=''
export DOTFILES_TOOL_WAS_SKIPPED=0
export DOTFILES_TOOL_ALREADY_INSTALLED=0
export DOTFILES_TOOL_NOT_COMPATIBLE_WITH_OS=0
export DOTFILES_TOOL_NOT_MEANT_FOR_OS=0
export DOTFILES_TOOL_QUARANTINED=0
export DOTFILES_SUDO_REQUIRED=0
export DOTFILES_MANAGED_BY_ZPLUG=0

function print_help () {
  cat << EOF
Usage: ./install.sh [options]'

Options:
  -t, --tool {toolname}     > The tool to install. Example "-t vim". Pass multiple times for multiple tools, example: "-t zsh -t rust"
  -u, --update              > Whether or not to update the selected tool. If not specfied installers will only run if
  --utils                   > Sources envs and utility functions, does not install any tool
                            > the tool is missing
  -v, --verbose             > If set a table with all tools and status will be printed as things are installed
  --no{-tool}               > Will skip the request 'tool'. Example './install -y --no-zsh' will install all except zsh
  -x                        > Equivalent to 'set -x' in bash. Does not work well with '-v'
                            > Defaults to [0] which only prints progress information
  -y, --no-prompt           > say yes to everything and automate as much as possible
  -h, --help                > Print this help menu
  --dry-run                 > Don't install anything, just print what would happen
EOF
}
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --dry-run)
      dry_run=1
      shift
      ;;
    -t)
      if [ -d "tools/$tool" ] ; then
        tools_requested+=("$2")
      else
        echo "Ignoring unknown tool $2"
      fi
      shift 2
      ;;
    --no-*)
      name="${1##*-}"
      name=$(tr '[:upper:]' '[:lower:]' <<< "$name")
      tools_to_skip+=("$name")
      shift
      ;;
    -v|--verbose)
      export DOTFILES_SHOW_OUTPUT=1
      shift
      ;;
    -x)
      set -x
      shift
      ;;
    -u|--update)
      update=1
      shift
      ;;
    --utils)
      utils=1
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
      echo "Unknown option: $1"
      print_help
      exit -1
      ;;
  esac
done

function resolve_largest_tool_size () {
  typeset -x -i largest_tool_size
  typeset -i max=0
  for t in "${tools_to_install[@]}" ; do
    len="${#t}"
    if [[ $len -gt $max ]] ; then
      max=$len
    fi
  done
  export DOTFILES_LARGET_TOOL_SIZE=$max
}

typeset progress
typeset -i -r progress_max=25
typeset -i processed_so_far=0

function reset_control_env_variables () {
  export DOTFILES_SHOULD_STOP_CURRENT=0
  export DOTFILES_TOOL_ALREADY_INSTALLED=0
  export DOTFILES_DEPENDENCY_MISSING=0
  export DOTFILES_REQUIRED_DEPENDENCY=''
  export DOTFILES_EXTRAS_ONLY=0
  export DOTFILES_TOOL_NOT_MEANT_FOR_OS=0
  export DOTFILES_TOOL_QUARANTINED=0
  export DOTFILES_UPDATE_RUN=0
  export DOTFILES_SUDO_REQUIRED=0
}

function unset_control_env_variables () {
  unset DOTFILES_SHOW_PROGRESS
  unset DOTFILES_SHOULD_STOP_CURRENT
  unset DOTFILES_TOOL_ALREADY_INSTALLED
  unset DOTFILES_DEPENDENCY_MISSING
  unset DOTFILES_REQUIRED_DEPENDENCY
  unset DOTFILES_EXTRAS_ONLY
  unset DOTFILES_TOOL_NOT_MEANT_FOR_OS
  unset DOTFILES_TOOL_QUARANTINED
  unset DOTFILES_SUDO_REQUIRED
  unset DOTFILES_PROMPT
  unset DOTFILES_MANAGED_BY_ZPLUG
  unset DOTFILES_CURRENT_TOOL
  unset DOTFILES_LARGET_TOOL_SIZE
  unset DOTFILES_UPDATE_RUN
}

function check_tool_metadata_to_save () {
  local tool="$1"
  local tool_folder="$DOTFILES_FULL_PATH/tools/$tool"
  if [ -f "$tool_folder/$tool.env" ] ; then
    # shellcheck disable=1090
    source "$tool_folder/$tool.env"
  fi

  if [ -f "$tool_folder/$tool.functions" ] ; then
    # shellcheck disable=1090
    source "$tool_folder/$tool.functions"
  fi

  if [ -f "$tool_folder/$tool.alias" ] ; then
    # shellcheck disable=1090
    source "$tool_folder/$tool.alias"
  fi
}

function evaluate-tool-file () {
  local tool="$1"
  local action="$2"
  local file_to_eval="tools/$tool/$action.sh"

  check_tool_metadata_to_save "$tool"

  export DOTFILES_CURRENT_TOOL="$tool"
  export DOTFILES_UPDATE_RUN=$update
  skip-if-installed
  if ! [ -f "$file_to_eval" ] ; then
    export DOTFILES_EXTRAS_ONLY=1
  else
    if (( ${DOTFILES_SHOW_OUTPUT:-0} )) ; then
      # shellcheck disable=1090
      source "$file_to_eval" "$tool"
    else
      # shellcheck disable=1090
      error_log="${tool}$tool_log_suffix"
      echo '' >> "$error_log"
      # shellcheck disable=1090
      source "$file_to_eval" "$tool" 1>"$error_log" 2>"$error_log"
      exit_code="$?"
      if [[ $exit_code == 0 ]] ; then
        rm -rf "$error_log"
      fi
    fi
  fi
}

function set_file_system_env () {
  curr=$(pwd)
  export DOTFILES_USER_HOME="${curr%/*}"
  export DOTFILES_USER="${DOTFILES_USER_HOME##*/}"
  export DOTFILES_FOLDER="${curr##*/}"
  export DOTFILES_FULL_PATH="$curr"
  export DOTFILES_BIN="$DOTFILES_FULL_PATH/bin"
  export DOTFILES_XDG="$DOTFILES_FULL_PATH/xdg"
  export DOTFILES_REPOS="$DOTFILES_FULL_PATH/repos"
  export DOTFILES_XDG_CONFIG_HOME="$DOTFILES_XDG/.config"
  export DOTFILES_XDG_DATA_HOME="$DOTFILES_XDG/.local/share"
  export DOTFILES_LSP="$DOTFILES_BIN/lsp"
  export XDG_CONFIG_HOME="$DOTFILES_XDG_CONFIG_HOME"
  export XDG_DATA_HOME="$DOTFILES_XDG_DATA_HOME"
}

function ensure_required_directories_exist () {
  mkdir -p "$DOTFILES_FULL_PATH"
  mkdir -p "$DOTFILES_BIN"
  mkdir -p "$DOTFILES_LSP"
  mkdir -p "$DOTFILES_XDG"
  mkdir -p "$XDG_CONFIG_HOME"
  mkdir -p "$XDG_DATA_HOME"
  mkdir -p "$DOTFILES_REPOS"
}

function scan_all_tools () {
  for f in `find "$DOTFILES_FULL_PATH/tools" -maxdepth 1 -type d` ; do
    name="${f##*/}" # remove the path, leaving only the tool name
    if [[ "$name" == "tools" ]] ; then
      # ignore the current dir
      continue
    fi
    all_tools+=("$name")
  done
  IFS=$'\n' all_tools=($(sort <<<"${all_tools[*]}"))
  unset IFS
}

function make_execution_plan () {
  local tools_to_consider=()
  if (( ${#tools_requested[@]} > 0 )) ; then
    tools_to_consider=("${tools_requested[@]}")
  else
    tools_to_consider=("${all_tools[@]}")
  fi

  should_install=1
  for t1 in "${tools_to_consider[@]}" ; do
    for t2 in "${tools_to_skip[@]}" ; do
      if [[ "$t1" = "$t2" ]] ; then
        should_install=0
        continue
      fi
    done
    if [ $should_install != 1 ] ; then
      should_install=1
    else
      tools_to_install+=("$t1")
    fi
  done
  IFS=$'\n'
  tools_to_skip=($(sort <<<"${tools_to_skip[*]}"))
  tools_to_install=($(sort <<<"${tools_to_install[*]}"))
  tools_to_install=($(uniq <<<"${tools_to_install[*]}"))
  unset IFS
}

function execute_plan () {
  for t in "${tools_to_install[@]}" ; do
    evaluate-tool-file "$t" "$action"
  done
}

function link_and_prepare_env_to_source () {
  echo 'Linking profiles...'
  ln -sfv "$DOTFILES_FULL_PATH/runcom/bash_profile" "$DOTFILES_USER_HOME/.bash_profile"
  ln -sfv "$DOTFILES_FULL_PATH/runcom/bash_profile" "$DOTFILES_USER_HOME/.bashrc"
  ln -sfv "$DOTFILES_FULL_PATH/.gitignore_global" "$DOTFILES_USER_HOME/.gitignore_global"
  ln -sfv "$DOTFILES_FULL_PATH/tools/zsh/zshrc" "$DOTFILES_USER_HOME/.zshrc"

  unset_control_env_variables
  dotfiles_env_file="$DOTFILES_FULL_PATH/bin/dotfiles.env"
  IFS=$'\n' envs=($(sort <<<"$(env | grep DOTFILES)"))
  unset IFS
  rm -rf "$DOTFILES_FULL_PATH/bin/dotfiles.env"

  echo "source $DOTFILES_FULL_PATH/funcs.min.sh" >> "$dotfiles_env_file"
  echo "source $DOTFILES_FULL_PATH/funcs.sh" >> "$dotfiles_env_file"


  for e in "${envs[@]}" ; do
    echo "export $e" >> "$dotfiles_env_file"
  done

  echo "export XDG_CONFIG_HOME=$DOTFILES_XDG_CONFIG_HOME" >> "$dotfiles_env_file"
  echo "export XDG_DATA_HOME=$DOTFILES_XDG_DATA_HOME" >> "$dotfiles_env_file"

  echo "source $DOTFILES_FULL_PATH/runcom/alias" >> "$dotfiles_env_file"

  for f in tools/*/*.env ; do
    echo "source $DOTFILES_FULL_PATH/$f" >> "$dotfiles_env_file"
  done

  for f in tools/*/*.functions ; do
    echo "source $DOTFILES_FULL_PATH/$f" >> "$dotfiles_env_file"
  done

  for f in tools/*/*.alias ; do
    echo "source $DOTFILES_FULL_PATH/$f" >> "$dotfiles_env_file"
  done

  echo 'Changing ownership of dotfiles bin to user...'
  chown -R "$DOTFILES_USER" "$DOTFILES_BIN"
  chown -R "$DOTFILES_USER" "$DOTFILES_FULL_PATH/tools/vim/.vim"
}

if (( ${utils:-0} )) ; then 
  link_and_prepare_env_to_source
  exit 0
fi

action='install'
set_file_system_env
. funcs.sh
find-os
ensure_required_directories_exist

printf "User: %-15s\n" "$DOTFILES_USER"
printf "Home: %-15s\n" "$DOTFILES_USER_HOME"
printf "OS:   %-15s\n" "$DOTFILES_RESOLVED_OS"

prompt_for_continue
scan_all_tools
make_execution_plan
resolve_largest_tool_size

if ! (( ${dry_run:-0} )) ; then
  execute_plan
fi

link_and_prepare_env_to_source

echo 'All done!'
cat << EOF
Remember to:
source ~/.bashrc
If you installed vim, run inside vim:
:PlugInstall
If you installed tmux, run inside tmux:
tmux source $DOTFILES_TMUX_CONF_FILE
CTRL-B + SHIFT-I to install plugins with tpm
If you installed zsh, consider:
# Make zsh the default shell
chsh -s $(type -p zsh)
# Make zsh the default shell for root
sudo chsh -s $(type -p zsh)
EOF
