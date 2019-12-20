#!/usr/bin/env bash

if ! (( "${DOTFILES_SHOULD_STOP_CURRENT:-0}" )) ; then

  echo "Will do:"
  echo "  - username: $DOTFILES_USER"
  echo "  - install go $DOTFILES_GOLANG_VERSION in $DOTFILES_GOLANG_ROOT"
  echo "  - go path set to $DOTFILES_GOLANG_GOPATH"
  if (( ${DOTFILES_PROMPT:-1} )) ; then
    echo 'Press any key to continue...'
    read -r -n 1
  fi

  if is-rpi ; then
    arch='linux-armv6l'
  elif is-ubuntu ; then
    arch='linux-amd64'
  elif is-macos ; then
    arch='darwin-amd64'
  else
    echo 'No arch defined. Aborting golang'
    exit 1
  fi
  tarball=go"$DOTFILES_GOLANG_VERSION"."$arch".tar.gz
  echo "Downloading go$DOTFILES_GOLANG_VERSION.${arch}.tar.gz..."

  wget -q "https://dl.google.com/go/${tarball}"
  tar -xf "$tarball" -C "$DOTFILES_BIN"
  rm -f "$tarball"

  echo "Changing ownership of $DOTFILES_GOLANG_ROOT to $DOTFILES_USER"
  sudo chown -R "$DOTFILES_USER:$DOTFILES_USER" "$DOTFILES_GOLANG_ROOT"

  echo "go $DOTFILES_GOLANG_VERSION is installed. Try go help"
fi
