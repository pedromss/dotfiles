#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

skip-if-requested 'rust'
skip-if-requested
skip-if-installed

default_host_triple=''
if is-rpi ; then
	# assume raspberry pi
	default_host_triple='armv7-unknown-linux-gnueabihf'
elif is-ubuntu ; then
	default_host_triple='x86_64-unknown-linux-gnu'
elif is-macos ; then
	default_host_triple='x86_64-apple-darwin'
else
	echo 'Unable to install Rust automatically'
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	exit 0
fi


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

cargo_env_file="$DOTFILES_USER_HOME/.cargo/env"
echo "Sourcing the config at ${cargo_env_file}..."
source './.env.source'
# shellcheck source=/dev/null
source "$cargo_env_file"
make-user-owner-of "$DOTFILES_USER_HOME/.cargo"

user_bin="$user_bin"
echo "Making symlinks in ${user_bin} to installer and uninstaller..."
tool_name=$(pwd)
tool_name=${tool_name##*/}

echo 'Rust installation process complete. Try rustup --help to ensure is installed!'
