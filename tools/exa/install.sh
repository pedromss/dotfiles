#!/usr/bin/env bash

[ "$(command -v exa)" ] && { echo 'exa already installed, skipping!'; exit 0; }
[ -f "$HOME/.cargo/bin/cargo" ] || { echo 'cargo is required to install exa'; exit 1; }

"$HOME/.cargo/bin/cargo" install exa
