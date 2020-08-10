function! GoDark() 
  set background=dark
  :colorscheme srcery
endfunction

function! GoLight()
  set background=light
  :colorscheme vim-material
endfunction

augroup ColorChoices
  autocmd!
  noremap <F8> :call GoDark()<cr>
  noremap <F9> :call GoLight()<cr>
augroup END


