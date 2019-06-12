#!/usr/bin/env bash

if [ -f ../../common.sh ]; then
  source ../../common.sh
fi

set +e

if [ $(command -v rustup) ]; then
  echo 'Rust is already installed, skipping!'
  exit 0
fi

default_host_triple=''
if [ -f /etc/os-release ]; then
  # possibly raspberry pi
  if [ $(cat /etc/os-release) =~ 'Raspbian' ]
  then
    # assume raspberry pi
    default_host_triple='armv7-unknown-linux-gnueabihf'
  fi
elif [[ "$OSTYPE" =~ 'darwin' ]]; then
  # assume mac os
  default_host_triple='x86_64-apple-darwin'
fi

! [ -z "$default_host_triple" ] || { echo 'Unable to install Rust automatically'; exit 0; }

echo 'Downloading rust...'
curl -sSL -o setup-rust https://sh.rustup.rs

echo 'Making it executable...'
chmod +x setup-rust

echo 'Running the install tool...'
./setup-rust \
  -y \
  --no-modify-path \
  --default-host "$default_host_triple" \
  --default-toolchain stable

echo 'Cleaning up...'
rm -rf setup-rust

cargo_env_file="$HOME/.cargo/env"
echo "Sourcing the config at ${cargo_env_file}..."
source "$cargo_env_file"

user_bin="$user_bin"
echo "Making symlinks in ${user_bin} to installer and uninstaller..."
tool_name=$(pwd)
tool_name=${tool_name##*/}
make_link ./install.sh "$user_bin/${install_prefix}${tool_name}"
make_link ./uninstall.sh "$user_bin/${uninstall_prefix}${tool_name}"

echo 'Rust installation process complete. Try rustup --help to ensure is installed!'
