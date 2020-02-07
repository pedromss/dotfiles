#!/usr/bin/env bash

if ! command_exists 'docker-langserver' ; then
  install_with_npm 'dockerfile-language-server-nodejs'
fi

if ! command_exists 'bash-language-server' ; then
  install_with_npm 'bash-language-server'
fi

if ! command_exists 'python-language-server' ; then
  install_with_pip 'jedi'
  install_with_pip 'python-language-server'
fi

# :CocInstall coc-json
# :CocInstall coc-metals
# :CocInstall coc-java
# :CocInstall coc-tsserver
# :CocInstall coc-vimlsp
# :CocInstall coc-yaml
# :CocInstall coc-vetur
# :CocInstall coc-highlight - disabled CTRL+S in insert mode
# :CocInstall coc-tslint-plugin
# :CocInstall coc-jest
