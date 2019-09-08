#!/usr/bin/env bash

echo 'Uninstalling rust with rustup...'
rustup self uninstall -y

echo 'Manually removing the .cargo that might have been left...'
rm -rf "$DOTFILES_USER_HOME/.cargo"

echo 'Rust should now be uninstalled from your system!'
