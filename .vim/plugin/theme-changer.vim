function! GoDark() 
  set background=dark
  :colorscheme miramare
endfunction

function! GoLight()
  set background=light
  :colorscheme vim-material
endfunction

command! GoLight :call GoLight()<cr>
command! GoDark :call GoDark()<cr>


