#!/usr/bin/env bash

. ../../runcom/.functions
. ../../common.sh
source common.sh

skip-if-not-installed 'entr'
uninstall-tool-from-git-repo "$DOTFILES_ENTR_REPO" 'make uninstall'
