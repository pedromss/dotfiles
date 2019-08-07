#!/usr/bin/env bash

(( ${verbose:-0} )) && set -x
. ../../funcs.sh

if ! [ "$(command -v tmux)" ]; then
  install-with-pkg-manager 'tmux'
else
  echo 'skipping: tmux is already installed!'
fi

tmux_plugins_dir="$HOME/.tmux/plugins"
tpm_dir="$tmux_plugins_dir/tpm"
echo "Installing tpm in ${tpm_dir}..."
if ! [ -d "$tpm_dir" ]; then
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm_dir"
else
  echo "skipping: tpm already installed in $tpm_dir"
fi

create-link-at-home ".tmux.conf"

save-config 'DOTFILES_TMUX_TPM_DIR' "$tpm_dir"
save-config 'DOTFILES_TMUX_PLUGINS_DIR' "$tmux_plugins_dir"

