#!/usr/bin/env bash

. ../../runcom/.functions
. ../../common.sh

skip-if-not-installed 'git'
uninstall-with-pkg-manager 'git'
rm-link-at-home '.gitconfig'

