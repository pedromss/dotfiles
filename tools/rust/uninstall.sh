#!/usr/bin/env bash

set +e
echo 'Uninstalling rust with rustup...'
rustup self uninstall -y

echo 'Manually removing the .cargo that might have been left...'
rm -rf "$HOME/.cargo"

user_bin="$HOME/bin"
echo "Removing symlinks in ${user_bin}..."
rm -f "$user_bin/install-rust"
rm -f "$user_bin/uninstall-rust"

echo 'Rust should now be uninstalled from your system!'
