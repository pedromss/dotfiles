#!/usr/bin/env bash

[ $(command -v bat) ] && { echo 'bat already installed, skipping!'; exit 0; }
[ -f "$HOME/.cargo/bin/cargo" ] || { echo 'cargo is required to install bat'; exit 1; }

"$HOME/.cargo/bin/cargo" install bat
