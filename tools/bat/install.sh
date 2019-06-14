#!/usr/bin/env bash

[ $(command -v bat) ] && { echo 'bat already installed, skipping!'; exit 0; }
[ $(command -v cargo) ] || { echo 'cargo is required to install bat'; exit 1; }

cargo install bat
