if exists('b:json_ftplugin')
  finish
endif
let b:json_ftplugin = 1
setlocal cursorline
setlocal cursorcolumn
setlocal foldmethod=indent
nnoremap <buffer> <leader>af :%!jq '.'<CR>
