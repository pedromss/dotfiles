#!/usr/bin/env bash

[ $(command -v mdcat) ] && { echo 'mdcat already installed, skipping!'; exit 0; }
[ $(command -v cargo) ] || { echo 'cargo is required to install mdcat'; exit 1; }

cargo install mdcat
