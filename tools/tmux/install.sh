#!/usr/bin/env bash

if ! [ $(command -v tmux) ]; then
  if [[ "$OSTYPE" =~ 'darwin' ]]; then
    # assume mac
    [ $(command -v brew) ] || { echo 'brew needs to be installed to install tmux'; exit 1; }
    brew install tmux
  else
    # fallback to debian/rasbian
    sudo apt-get install tmux
  fi

else
  echo 'tmux is already installed, skipping!'
fi

tmux_plugins_dir="$HOME/.tmux/plugins"
tpm_dir="$tmux_plugins_dir/tpm"
echo "Installing tpm in ${tpm_dir}..."
if ! [ -d "$tpm_dir" ]; then
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm_dir"
else
  echo "tpm already installed in $tpm_plugins_dir"
fi

ln -svf "$(pwd)/.tmux.conf" "$HOME"
