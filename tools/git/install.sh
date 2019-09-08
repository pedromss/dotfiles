#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

save-alias 'gl' 'git pull'
save-alias 'gp' 'git push'
save-alias 'gst' 'git status -s --branch -uall'
save-alias 'gstl' 'git status --long --branch -uall -vv'
save-alias 'glg' 'git log --graph --pretty format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset" --abbrev-commit --date relative'
save-alias 'gau' 'git add -u'
save-alias 'gaa' 'git add -A'
save-alias 'gcm' 'git commit -m'
save-alias 'gbr' 'git branch -vv'
save-alias 'gbrr' 'git branch -r -vv'
save-alias 'gunstage' 'git reset HEAD --'
save-alias 'gchall' 'git checkout -- .'
save-alias 'gbname' 'git rev-parse --abbrev-ref HEAD'
save-alias 'gtagd' 'git push --delete origin'
save-alias 'gtagp' 'git push --tags'
save-alias 'gtagf' 'git fetch --tags'
save-alias 'gco' 'git checkout'
save-alias 'glc' 'git rev-parse --short HEAD'
save-alias 'glcc' 'git rev-parse --short HEAD | pbcopy'
save-alias 'gbn' 'gbname | pbcopy'

save-source "${DOTFILES_FULL_PATH:?}/tools/git/git-functions.sh"
create-tool-link-at-home 'git/.gitconfig'

skip-if-installed 'git'
install-with-pkg-manager 'git'
