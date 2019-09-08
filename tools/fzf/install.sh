#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

skip-if-requested 'fzf'

save-source "${DOTFILES_FULL_PATH:?}/tools/fzf/.env.source"

skip-if-dir-exists 'fzf' "${DOTFILES_USER_HOME:?}/.fzf"

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
echo "Installing fzf@$DOTFILES_FZF_VERSION"
cd ~/.fzf && git fetch --tags 1>/dev/null && git checkout "$DOTFILES_FZF_VERSION"
~/.fzf/install --key-bindings --completion --update-rc --no-fish
