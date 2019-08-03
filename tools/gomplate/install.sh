#!/usr/bin/env bash

! [ "$(command -v gomplate)" ] || { echo 'gomplate is already installed, skipping!'; exit 0; }

GO111MODULE=off go get -v -u github.com/hairyhenderson/gomplate/cmd/gomplate
