#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$HOME/.config"

### Reorganize dotfiles repo ###

# Create directories
mkdir -p "$DOTFILES/zellij"
mkdir -p "$DOTFILES/config/nvim/lua"
mkdir -p "$DOTFILES/archive"

# Move zellij config
if [ -f "$DOTFILES/config.kdl" ]; then
  mv "$DOTFILES/config.kdl" "$DOTFILES/zellij/config.kdl"
fi

# Move nvim personal config dirs from ~/.config/nvim into dotfiles
for dir in config plugins; do
  if [ -d "$CONFIG/nvim/lua/$dir" ] && [ ! -L "$CONFIG/nvim/lua/$dir" ]; then
    cp -r "$CONFIG/nvim/lua/$dir" "$DOTFILES/config/nvim/lua/$dir"
  fi
done

# Archive unused files
for file in .Xdefaults Xresources .tmux.conf .vimrc .bashrc .zshrc helix.toml .ideavimrc .iex.exs init.lua; do
  if [ -f "$DOTFILES/$file" ]; then
    mv "$DOTFILES/$file" "$DOTFILES/archive/$file"
  fi
done

### Symlinks ###

link() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "Backing up existing $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi
  ln -sfn "$src" "$dst"
  echo "Linked $dst -> $src"
}

link "$DOTFILES/config.fish"            "$CONFIG/fish/config.fish"
link "$DOTFILES/starship.toml"          "$CONFIG/starship.toml"
link "$DOTFILES/zellij/config.kdl"     "$CONFIG/zellij/config.kdl"
link "$DOTFILES/.gitconfig"            "$HOME/.gitconfig"
link "$DOTFILES/.gitignore_global"     "$HOME/.gitignore_global"

# nvim — symlink only personal config dirs, leave the rest to LazyVim
link "$DOTFILES/config/nvim/lua/config"  "$CONFIG/nvim/lua/config"
link "$DOTFILES/config/nvim/lua/plugins" "$CONFIG/nvim/lua/plugins"

# Local-only (not symlinked on server)
if [ "$(uname)" != "Linux" ] || [ -n "${DISPLAY:-}" ] || [ -n "${WAYLAND_DISPLAY:-}" ]; then
  link "$DOTFILES/alacritty.toml" "$CONFIG/alacritty/alacritty.toml"
fi

echo ""
echo "Done."
