function! s:ResolveVimIndent()
  if expand('%') =~# '.vimrc\|init.vim' 
    setlocal foldmethod=marker
  else
    setlocal foldmethod=indent
  endif
endfunction

augroup vim_files_custom
  autocmd!
  autocmd FileType vim call <SID>ResolveVimIndent()
augroup END

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname : 'UNKNOWN'
endfunction

function! Datetime()
  return strftime('%c')
endfunction
