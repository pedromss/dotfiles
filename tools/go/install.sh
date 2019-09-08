#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${DOTFILES_FULL_PATH:?}/funcs.sh"

username="$DOTFILES_USER"
go_version="$DOTFILES_GOLANG_VERSION"
go_root_parent="$DOTFILES_GOLANG_ROOT_PARENT"
go_root="$go_root_parent/$DOTFILES_GOLANG_ROOT"
go_path="$DOTFILES_GOLANG_GOPATH"

save-alias 'gom' 'GO111MODULE=on go'
save-env 'PATH' "$PATH:$DOTFILES_GOLANG_GOPATH/bin:/usr/local/go/bin"
save-env 'GOPATH' "$DOTFILES_GOLANG_GOPATH"
save-env 'GO111MODULE' 'off'

skip-if-requested 'golang'
skip-if-installed 'go'

echo "Will do:"
echo "  - username: ${username}"
echo "  - install go ${go_version} in ${go_root}"
echo "  - go path set to ${go_path}"
if (( ${DOTFILES_PROMPT:-1} )) ; then
  echo 'Press any key to continue...'
  read -r -n 1
fi

tarball=go${go_version}.linux-armv6l.tar.gz
echo "Downloading go${go_version}.linux-armv6l.tar.gz..."
sudo wget -qO- "https://dl.google.com/go/${tarball}" | sudo tar xz -C "$go_root_parent"

echo "Changing ownership of ${go_root} to ${username}"
sudo chown -R "${username}:${username}" "$go_root"

echo "go ${go_version} is installed. Try go help"
