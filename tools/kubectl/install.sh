#!/usr/bin/env bash 

. "${DOTFILES_FULL_PATH:?}/funcs.sh"

save-alias 'kdev' 'kubectl --context=dev'
save-alias 'kdevrls' 'kubectl --context=dev --namespace=rls-stubbed-functional'
