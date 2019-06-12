#!/usr/bin/env bash

[ $(command -v exa) ] && { echo 'Exa alreadu installed, skipping!'; exit 0; }
[ $(command -v cargo) ] || { echo 'Cargo is required to install exa'; exit 1; }

cargo install exa
