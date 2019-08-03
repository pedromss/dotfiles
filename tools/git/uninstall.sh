#!/usr/bin/env bash

source ../../runcom/.functions
source ../../common.sh

skip-if-not-installed 'git'
uninstall-with-pkg-manager 'git'
rm-link-at-home '.gitconfig'

