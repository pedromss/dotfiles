function! IsShebang(line)
  if match(a:line, '#!.*') == -1
    return 0
  endif
  return 1
endfunction

function! AddShebang()
  " TODO dont use marks when it is a new file
  let lines = getline(0, 50)
  let shebangLines = filter(lines, 'IsShebang(v:val)')
  if len(shebangLines) > 0 
    return
  endif
  if &filetype ==? ''
    echo 'Setting filetype to "sh"'
    set filetype=sh
    return AddShebang()
  elseif &filetype !=? 'sh'
    echo 'Filetype is ' . &filetype . ' not adding the shebang line'
  else
    let shebang = get(g:, 'shebanger_shebang_line', '#!/usr/bin/env bash')
    :execute 'normal! mtggI' . shebang "\<cr>\<esc>o\<esc>`t"
  endif
endfunction
