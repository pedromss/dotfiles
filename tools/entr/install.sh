#!/usr/bin/env bash

set -x

source ../../runcom/.functions
source ../../common.sh
source common.sh

skip-if-installed 'entr'

if is-macos ; then
  install-tool-from-git-repo \
    "$entr_repo" \
    "$entr_version" \
    './configure && make && make install'
    else
      install-with-pkg-manager 'entr'
    fi
