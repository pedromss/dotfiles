function! GoDark() 
  set background=dark
  let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }
  :colorscheme gruvbox-material
endfunction

function! GoLight()
  set background=light
  let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
  :colorscheme vim-material
endfunction

command! GoLight :call GoLight()<cr>
command! GoDark :call GoDark()<cr>


