#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --no-rust)
      install_rust=0
      shift
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done


set -- "$@" "${POSITIONAL[@]}"
skip-if-requested "$install_rust"
skip-if-installed "rustup"

default_host_triple=''
if [ -f /etc/os-release ]; then
  # possibly raspberry pi
  if [[ $(cat /etc/os-release) =~ 'Raspbian' ]]
  then
    # assume raspberry pi
    default_host_triple='armv7-unknown-linux-gnueabihf'
  fi
elif [[ "$OSTYPE" =~ 'darwin' ]]; then
  # assume mac os
  default_host_triple='x86_64-apple-darwin'
fi

[ -n "$default_host_triple" ] || { echo 'Unable to install Rust automatically'; exit 1; }

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
