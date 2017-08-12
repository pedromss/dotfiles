for DOTFILE in `find ~/.dotfiles/runcom`
do
  if ! [[ "$DOTFILE" =~ \.bash\_profile(\.swp)? ]]
  then
    [ -f "$DOTFILE" ] &&  source "$DOTFILE"
  fi
done

