echo 'Much go'
if exists('b:go_ftplugin')
  finish
endif
let b:go_ftplugin = 1

function! CloseGoErrors()
  let buffers = filter(range(1, bufnr('$')), 'bufexists(v:val)')
  echo buffers
endfunction

":call SetTabs(4)
:setlocal foldmethod=syntax
:setlocal nolist

