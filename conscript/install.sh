#!/usr/bin/env bash
source $HOME/dotfiles/runcom/.functions

if command_exists cs
then
  echo 'Conscript already installed. Skipping!'
  exit 0
fi

echo 'Installing conscript...'

wget https://raw.githubusercontent.com/foundweekends/conscript/master/setup.sh -O - | sh
