#! /usr/bin/env bash

set -e
. runcom/.functions
. funcs.sh

logs_dir=logs

in_username="$USER"
in_fzf_version='0.18.0'
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --user)
      in_username=$2
      shift 2
      ;;
    --no-golang)
      in_install_golang=0
      shift
      ;;
    --no-rust)
      in_install_rust=0
      shift
      ;;
    --fzf-version)
      in_fzf_version=$2
      shift 2
      ;;
    --no-fzf)
      in_install_fzf=0
      shift
      ;;
    --no-zsh)
      in_install_zsh=0
      shift
      ;;
    --no-nvim)
      in_install_nvim=0
      shift
      ;;
    --no-zsh-plugins)
      in_install_zsh_plugins=0
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
echo "POSITIONAL after main: $POSITIONAL"
source ./common.sh
mkdir -p $logs_dir
# ==================================================
# Files to link
# ==================================================
zsh_files_tolink[0]='zsh/.zshrc'
zsh_files_tolink[1]='zsh/.zfunctions'

ctags_files_tolink[0]='tools/ctags/.ctags'
# ==================================================
# Make links
# ==================================================
create-link-at-home 'runcom/.custom_profile'
create-link-at-home 'runcom/.bash_profile'
# ==================================================
# Tools
# ==================================================
#install-toolset \
#tmux \
#entr

#if (( ${in_install_rust:-1} )) ; then
#install-toolset \
#rustup \
#exa \
#bat \
#mdcat
#fi

install-tool 'go' $@
install-tool 'gomplate' $@
install-tool 'vault' $@

#if (( ${in_install_golang:-1} )) ; then
#install-toolset \
#go \
#gomplate \
#vault
#fi

install_fzf "$in_fzf_version"
install_zsh_plugins "$zsh_plugins_folder"
generate_brewfile

# ==================================================
# Shutdown
# ==================================================
echo 'Be sure to checkout:'
echo ' - https://github.com/ryanoasis/nerd-fonts'
echo ' - https://github.com/so-fancy/diff-so-fancy'

echo 'All done!'
