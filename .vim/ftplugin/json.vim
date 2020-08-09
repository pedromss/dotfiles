if exists('b:json_ftplugin')
  finish
endif
let b:json_ftplugin = 1
nnoremap <buffer> <leader>af :%!jq '.'<CR>
