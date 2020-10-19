if exists('b:ts_ftplugin')
  finish
endif
let b:ts_ftplugin = 1
:call SetTabs(2)

setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal foldmethod=syntax
setlocal list
setlocal cursorline
setlocal nocursorcolumn

nnoremap <leader>af :%!prettier --parser typescript
