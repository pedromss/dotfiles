if exists('b:vim_ftplugin')
  finish
endif
let b:vim_ftplugin = 1
nnoremap <leader>mf o" Fold description <esc>20a-<esc>a {{{<cr><cr>}}}<esc>kcc

" Operator pending
onoremap ih :<c-u>execute "normal! ?^==\\+$\\\\|^--\\+$\r:nohlsearch\rkvg_"<cr>
