#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --no-nvim)
      in_install_nvim=0
      shift
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

set -- "$@" "${POSITIONAL[@]}"

mkdir -p "${XDG_CONFIG_HOME:?}/nvim"
mkdir -p "${XDG_DATA_HOME:?}/nvim"
make_link "${DOTFILES_FULL_PATH:?}/tools/nvim/init.vim" "${XDG_CONFIG_HOME:?}/nvim/init.vim"

skip-if-requested 'nvim' "$in_install_nvim"

if is-macos ; then
  install-with-pkg-manager 'neovim'
elif is-ubuntu ; then
  echo 'Installing prerequisites to build neovim...'

  export CMAKE_INSTALL_PREFIX="$DOTFILES_NVIM_INSTALLATION"

  install-with-pkg-manager 'ninja-build'
  install-with-pkg-manager 'gettext'
  install-with-pkg-manager 'libtool'
  install-with-pkg-manager 'libtool-bin'
  install-with-pkg-manager 'autoconf'
  install-with-pkg-manager 'automake'
  install-with-pkg-manager 'cmake'
  install-with-pkg-manager 'g++'
  install-with-pkg-manager 'pkg-config'
  install-with-pkg-manager 'unzip'

  if -d [ "$DOTFILES_NVIM_REPO" ]; then
    mv "$DOTFILES_NVIM_REPO" "${DOTFILES_NVIM_REPO:?}bak"
  fi
  clone-from-github 'neovim/neovim' "$DOTFILES_NVIM_REPO"
  rm -rf "${DOTFILES_NVIM_REPO}bak"
  current=$(pwd)
  cd "$DOTFILES_NVIM_REPO" || exit
  git fetch --tags
  git checkout stable
  rm -rf build/  # clear the CMake cache
  make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$DOTFILES_NVIM_INSTALLATION"
  make install
  cd "$current" || exit
else
  echo 'Unsuppoted OS to install neovim!'
fi

