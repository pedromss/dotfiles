#!/usr/bin/env bash

[ $(command -v go)  ] && { echo 'go is already installed, skipping!'; exit 0; }

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
    -y)
      prompt=0
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
    POSITIONAL+=("$1")
    shift
    ;;
  esac
done

set -- "${POSITIONAL[@]}"

if (( ${prompt:-1} )) ; then
  echo "Will do:"
  echo "  - username: ${username}"
  echo "  - install go ${go_version} in ${go_root}"
  echo "  - go path set to ${go_path}"
  echo 'Press any key to continue...'
  read -n 1
fi

wget -q "https://dl.google.com/go/go${go_version}.linux-armv6l.tar.gz"

tar -C "$go_root_parent" -xvf "go${go_version}.linux-arm6l.tar.gz"
sudo chown -R "${username}:${username}" "$go_root"
