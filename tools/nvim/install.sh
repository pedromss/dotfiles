#!/usr/bin/env bash

make_link "$DOTFILES_FULL_PATH/tools/nvim/init.vim" "$DOTFILES_NVIM_CONFIG_FOLDER/init.vim"

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  if is_macos ; then
    install_with_pkg_manager 'neovim'
  elif is_ubuntu ; then
    check_is_root
    if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
      echo 'Installing prerequisites to build neovim...'

      export CMAKE_INSTALL_PREFIX="$DOTFILES_NVIM_INSTALLATION"

      install_with_pkg_manager 'ninja-build'
      install_with_pkg_manager 'gettext'
      install_with_pkg_manager 'libtool'
      install_with_pkg_manager 'libtool-bin'
      install_with_pkg_manager 'autoconf'
      install_with_pkg_manager 'automake'
      install_with_pkg_manager 'cmake'
      install_with_pkg_manager 'g++'
      install_with_pkg_manager 'pkg-config'
      install_with_pkg_manager 'unzip'

      if ! [ -d "$DOTFILES_NVIM_REPO" ]; then
        clone_from_github 'neovim/neovim' "$DOTFILES_NVIM_REPO"
      fi
      current=$(pwd)
      cd "$DOTFILES_NVIM_REPO" || exit 1
      git fetch --tags
      git checkout stable
      rm -rf build/  # clear the CMake cache
      make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$DOTFILES_NVIM_INSTALLATION"
      make install
      cd "$current" || exit 1
    fi
  else
    echo 'Unsuppoted OS to install neovim!'
  fi
fi
