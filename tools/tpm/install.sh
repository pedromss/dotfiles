#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

tpm_dir=""
while [[ $# -gt 0 ]]
do
  case "$1" in
    --tpm-dir)
      tpm_dir="$1"
      shift
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

set -- "${POSITIONAL[@]}"

if ! [ -z "$tpm_dir" ]; then

  if ! [ -z "$DOTFILES_TMUX_TPM_DIR" ]; then
    tpm_dir="$DOTFILES_TMUX_PLUGINS_DIR/tpm"
  fi
else
  default_dir="$HOME/tpm"
  echo "Installing TPM in $default_dir"
  tpm_dir="$default_dir"
fi
save-config 'DOTFILES_TMUX_TPM_DIR' "$tpm_dir"
clone-from-github 'tmux-plugins/tpm' "$tpm_dir"

