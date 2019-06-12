#!/usr/bin/env bash

[ $(command -v bat) ] && { echo 'Bat alreadu installed, skipping!'; exit 0; }
[ $(command -v cargo) ] || { echo 'Cargo is required to install exa'; exit 1; }

cargo install bat
