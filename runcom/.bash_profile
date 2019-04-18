#!/usr/bin/env bash
for DOTFILE in `find $HOME/dotfiles/runcom`
do
  if ! [[ "$DOTFILE" =~ \.bash\_profile(\.swp)? ]]
  then
    [ -f "$DOTFILE" ] &&  source "$DOTFILE"
  fi
done
