#!/usr/bin/env bash

jdt_install_dir="$DOTFILES_LSP/jdt"
if ! [ -d "$jdt_install_dir" ]; then
  jdt_lsp_version=0.47.0
  jdt_lsp_tarball_id="jdt-language-server-${jdt_lsp_version}-201911150945"

  download-tarball-to \
    "http://download.eclipse.org/jdtls/milestones/${jdt_lsp_version}/${jdt_lsp_tarball_id}.tar.gz" \
    "$jdt_install_dir"
fi
