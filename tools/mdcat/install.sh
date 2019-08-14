#!/usr/bin/env bash

skip-if-installed 'mdcat'
require-tool 'cargo'
cargo install mdcat
