#!/usr/bin/env bash

make_link "$DOTFILES_FULL_PATH/tools/nvim/init.vim" "$DOTFILES_NVIM_CONFIG_FOLDER/init.vim"


if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  if is-macos ; then
    install-with-pkg-manager 'neovim'
  elif is-ubuntu ; then
    check_is_root
    if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
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

      if ! -d [ "$DOTFILES_NVIM_REPO" ]; then
        clone-from-github 'neovim/neovim' "$DOTFILES_NVIM_REPO"
      fi
      current=$(pwd)
      cd "$DOTFILES_NVIM_REPO" || exit
      git fetch --tags
      git checkout stable
      rm -rf build/  # clear the CMake cache
      make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$DOTFILES_NVIM_INSTALLATION"
      make install
      cd "$current" || exit
    fi
  else
    echo 'Unsuppoted OS to install neovim!'
  fi
fi
