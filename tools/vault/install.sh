#!/usr/bin/env bash

! [ "$(command -v vault)" ] || { echo 'vault is already installed, skipping!'; exit 0; }

GO111MODULE=off go get -v -u github.com/hashicorp/vault
