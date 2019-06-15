#!/usr/bin/env bash

[ $(command -v mdcat) ] && { echo 'mdcat already installed, skipping!'; exit 0; }
[ -f "$HOME/.cargo/bin/cargo" ] || { echo 'cargo is required to install mdcat'; exit 1; }

"$HOME/.cargo/bin/cargo" install mdcat
