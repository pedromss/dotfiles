#!/usr/bin/env bash

. ../../runcom/.functions
. ../../common.sh

skip-if-installed 'git'
install-with-pkg-manager 'git'
create-tool-link-at-home "tools/git/.gitconfig"
