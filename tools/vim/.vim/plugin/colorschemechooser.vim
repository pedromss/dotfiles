function! LoadColorScheme(scheme)
  if filereadable(expand('~/.vim/colors/' . a:scheme . '.vim'))
    execute ':colorscheme ' . a:scheme
  endif
endfunction
