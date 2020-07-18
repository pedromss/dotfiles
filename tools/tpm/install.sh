#!/usr/bin/env bash

depends_on 'tmux'
skip_if_dir_exists "$DOTFILES_TPM_DIR"

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  clone_from_github 'tmux-plugins/tpm' "$DOTFILES_TPM_DIR"
fi

