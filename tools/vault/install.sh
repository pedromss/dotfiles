#!/usr/bin/env bash

skip-if-requested 'golang'
skip-if-requested
skip-if-installed

GO111MODULE=off go get -v -u github.com/hashicorp/vault
