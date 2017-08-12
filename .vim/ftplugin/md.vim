if exists('b:md_ftplugin')
  finish
endif

let b:md_ftplugin = 1
:setlocal formatoptions-=t " remove line wrap if textwidth is exceeded

" Cursor on markdown text. cih will delete the header of the current paragraph
onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
onoremap ah :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>
