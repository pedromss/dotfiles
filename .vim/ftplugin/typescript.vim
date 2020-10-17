if exists('b:ts_ftplugin')
  finish
endif
let b:ts_ftplugin = 1
:call SetTabs(2)

nnoremap <leader>af :%!prettier --parser typescript
