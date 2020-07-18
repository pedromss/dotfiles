#!/usr/bin/env bash

skip_if_dir_exists "$DOTFILES_FZF_DIR"

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  curr=$(pwd)
  git clone --depth 1 https://github.com/junegunn/fzf.git "$DOTFILES_FZF_DIR"
  echo "Installing fzf@$DOTFILES_FZF_VERSION"
  echo "Installing fzf@master"
  cd "$DOTFILES_FZF_DIR"
  #git fetch --tags 1>/dev/null && git checkout "$DOTFILES_FZF_VERSION"
  # This next line fails the whole thing if curl or wget don't exit
  # shellcheck disable=1090
  ./install --key-bindings --completion --no-update-rc --no-fish
  # shellcheck disable=2164
  cd "$curr"
fi
