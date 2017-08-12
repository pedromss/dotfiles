if exists('b:sh_ftplugin')
  finish
endif
let b:sh_ftplugin = 1
:set formatoptions-=t " remove line wrap if textwidth is exceeded
