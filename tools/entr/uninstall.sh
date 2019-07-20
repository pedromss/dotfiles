#!/usr/bin/env bash

. ../../runcom/.functions
. ../../common.sh
. ./common.sh

skip-if-not-installed 'entr'
uninstall-tool-from-git-repo "$entr_repo" 'make uninstall'
