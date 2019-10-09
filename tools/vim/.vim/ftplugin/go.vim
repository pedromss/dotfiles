function! CloseGoErrors()
  let buffers = filter(range(1, bufnr('$')), 'bufexists(v:val)')
  echo buffers
endfunction
