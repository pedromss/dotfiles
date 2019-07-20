#!/usr/bin/env bash

(( ${verbose:-0} )) && set -x
[ $(command -v go)  ] && { echo 'go is already installed, skipping!'; exit 0; }

echo "POSITIONAL before go: $POSITIONAL"
username='pedromss'
go_version='1.12.6'
go_root_parent='/usr/local'
go_root="$go_root_parent/go"
go_path='~/go'
while [[ $# -gt 0 ]]
do
  case "$1" in
    -u|--username)
      username="$2"
      shift 2
      ;;
    -v|--version)
      go_version="$2"
      shift 2
      ;;
    -y|--no-prompt)
      prompt=0
      POSITIONAL+=("$1")
      shift
      ;;
    --go-root)
      go_root="$2"
      shift 2
      ;;
    --go-path)
      go_path="$2"
      shift 2
      ;;
    *)
      for x in "${POSITIONAL[@]}" ; do
        if [[ "$x" == "$1" ]]; then
          add=0
        fi
      done
      (( ${add:-1} )) && POSITIONAL+=("$1")
      shift
      ;;
  esac
done

set -- "${POSITIONAL[@]}"
echo "POSITIONAL after go: $POSITIONAL"

echo "Will do:"
echo "  - username: ${username}"
echo "  - install go ${go_version} in ${go_root}"
echo "  - go path set to ${go_path}"
if (( ${prompt:-1} )) ; then
  echo 'Press any key to continue...'
  read -n 1
fi

tarball=go${go_version}.linux-armv6l.tar.gz
echo "Downloading go${go_version}.linux-armv6l.tar.gz..."
sudo wget -qO- "https://dl.google.com/go/${tarball}" | sudo tar xz -C "$go_root_parent"

echo "Changing ownership of ${go_root} to ${username}"
sudo chown -R "${username}:${username}" "$go_root"

echo "go ${go_version} is installed. Try go help"
