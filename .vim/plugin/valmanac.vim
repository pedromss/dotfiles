" The idea is to have commands that bring up text that I can't keep in memory
" forever and don't want to google every time. Think TL:DR for vim help files
function! valmanac#help_panes() 
  let l:help_text = '
        \ "Swap top/bottom or left/right split\n
        \ Ctrl+W R
        \ "Break out current window into a new tabview
        \ Ctrl+W T
        \ "Close every window in the current tabview but the current one
        \ Ctrl+W o '
  echo l:help_text
endfunction
