#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-requested 'rust'
skip-if-requested 'rustup'

save-source "${DOTFILES_FULL_PATH:?}/tools/rustup/.env.source"

skip-if-installed 'rustup'

default_host_triple=''
if is-rpi ; then
  # assume raspberry pi
  default_host_triple='armv7-unknown-linux-gnueabihf'
elif is-ubuntu ; then
  default_host_triple='x86_64-unknown-linux-gnu'
elif is-macos ; then
  default_host_triple='x86_64-apple-darwin'
else
  echo 'Unable to set default-host-triple automatically'
fi


echo 'Downloading rust...'
curl -sSL -o setup-rust https://sh.rustup.rs

echo 'Making it executable...'
chmod +x setup-rust

echo 'Running the install tool...'
if [ -z "$default_host_triple" ]; then
  ./setup-rust -y --no-modify-path --default-toolchain stable
else
  ./setup-rust -y --no-modify-path --default-host "$default_host_triple" --default-toolchain stable
fi

echo 'Cleaning up...'
rm -rf setup-rust

cargo_env_file="$DOTFILES_USER_HOME/.cargo/env"
echo "Sourcing the config at ${cargo_env_file}..."
. .env.source

# shellcheck disable=SC1090
. "$cargo_env_file"
make-user-owner-of "$DOTFILES_USER_HOME/.cargo"

echo 'Rust installation process complete. Try rustup --help to ensure is installed!'
