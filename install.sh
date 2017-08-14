USER=$1

# Make sure a user is specified
if [ ! $USER ]
then
  echo 'Please specify a user'
  exit 1
fi

# Make sure the .dotfiles directory exists
if [ ! -d "/Users/$USER/.dotfiles" ]
then
  echo "No .dotfiles directory under /Users/$USER"
  exit 2
fi

ln -sfv "/Users/$USER/.dotfiles/runcom/.bash_profile" ~
ln -sfv "/Users/$USER/.dotfiles/runcom/.aliases" ~
ln -sfv "/Users/$USER/.dotfiles/runcom/.env" ~
ln -sfv "/Users/$USER/.dotfiles/vim/.vimrc" ~
ln -sfv "/Users/$USER/.dotfiles/zsh/.zshrc" ~
ln -sfv "/Users/$USER/.dotfiles/tern/.tern-project" ~

