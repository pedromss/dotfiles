if exists('b:md_ftplugin')
  finish
endif
let b:md_ftplugin = 1
:setlocal formatoptions-=t " remove line wrap if textwidth is exceeded
