for DOTFILE in `find $HOME/dotfiles/runcom`
do
  if ! [[ "$DOTFILE" =~ \.bash\_profile(\.swp)? ]]
  then
    [ -f "$DOTFILE" ] &&  source "$DOTFILE"
  fi
done

nvm_launcher_location='/usr/local/opt/nvm/nvm.sh'

if [[ -f "$nvm_launcher_location" ]] 
then
  source $nvm_launcher_location
fi

