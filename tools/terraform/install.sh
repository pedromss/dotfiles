#!/usr/bin/env bash

! [ "$(command -v terraform)" ] || { echo 'terraform is already installed, skipping!'; exit 0; }

GO111MODULE=off go get -v -u github.com/hashicorp/terraform
