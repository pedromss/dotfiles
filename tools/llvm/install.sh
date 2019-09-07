#!/usr/bin/env bash

. "${DOTFILES_FULL_PATH:?}/funcs.sh"

only-if-os-is 'llvm' 'ubuntu'

# From http://apt.llvm.org/
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
# Fingerprint: 6084 F3CF 814B 57C1 CF12 EFD5 15CF 4D18 AF4F 7421

sudo add-apt-repository 'deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main'

sudo apt-get update
sudo apt-get -y install \
  libllvm-8-ocaml-dev \
  libllvm8 \
  llvm-8 \
  llvm-8-dev \
  llvm-8-doc \
  llvm-8-examples \
  llvm-8-runtime \
  clang-8 \
  clang-tools-8 \
  clang-8-doc \
  libclang-common-8-dev \
  libclang-8-dev \
  libclang1-8 \
  clang-format-8 \
  python-clang-8 \
  libclang1 \
  libclang-dev

sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100
sudo update-alternatives --install /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-8 100
