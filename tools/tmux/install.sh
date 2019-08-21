#!/usr/bin/env bash

. "$DOTFILES_FULL_PATH/funcs.sh"

tmux_plugins_dir="$DOTFILES_USER_HOME/.tmux/plugins"

create-link-at-home 'tools/tmux/.tmux.conf'

save-config 'DOTFILES_TMUX_PLUGINS_DIR' "$tmux_plugins_dir"

skip-if-installed 'tmux'
install-with-pkg-manager 'tmux'



