#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

skip-if-os-is 'conscript' 'rpi'

save-env "CONSCRIPT_HOME" "${DOTFILES_USER_HOME:?}/.conscript"
save-env "CONSCRIPT_OPTS" '"-XX:MaxPermSize=512M -Dfile.encoding=UTF-8"'
save-source "${DOTFILES_FULL_PATH:?}/tools/conscript/path.sh"

skip-if-installed 'cs'
conscript_version=${1:-'v0.5.0'}
echo 'Installing conscript...'
wget "https://raw.githubusercontent.com/foundweekends/conscript/${conscript_version}/setup.sh" -O - | sh 
echo 'Conscript installed. Try "cs --help"'
