if exists('b:go_ftplugin')
  finish
endif
let b:go_ftplugin = 1

setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal noexpandtab
setlocal foldmethod=syntax
setlocal nolist
setlocal cursorline
setlocal nocursorcolumn

augroup go_remove_folds
  autocmd!
  autocmd BufEnter *.go execute 'normal! zR'
augroup END
