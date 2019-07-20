#!/usr/bin/env bash 

. ../../runcom/.functions
. ../../funcs.sh

skip-if-installed 'ctags'
install-with-pkg-manager 'ctags'
create-link-at-home 'tools/ctags/.ctags'

