#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

tmux_plugins_dir="$HOME/.tmux/plugins"
tpm_dir="$tmux_plugins_dir/tpm"

create-link-at-home 'tools/tmux/.tmux.conf'

save-config 'DOTFILES_TMUX_TPM_DIR' "$tpm_dir"
save-config 'DOTFILES_TMUX_PLUGINS_DIR' "$tmux_plugins_dir"

echo "Installing tpm in ${tpm_dir}..."
if ! [ -d "$tpm_dir" ]; then
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm_dir"
else
  echo "skipping: tpm already installed in $tpm_dir"
fi

skip-if-installed 'tmux'
install-with-pkg-manager 'tmux'



