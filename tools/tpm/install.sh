#!/usr/bin/env bash

depends_on 'tmux'
skip-if-dir-exists "$DOTFILES_TPM_DIR"

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then
  clone-from-github 'tmux-plugins/tpm' "$DOTFILES_TPM_DIR"
fi

