#!/usr/bin/env bash

set -x

source ../../runcom/.functions
source ../../common.sh
source common.sh

skip-if-installed 'entr'
install-tool-from-git-repo \
  "$repo" \
  "$version" \
  './configure && make && make install'
