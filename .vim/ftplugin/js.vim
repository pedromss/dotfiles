if exists('b:js_ftplugin')
  finish
endif
let b:js_ftplugin = 1
:call SetTabs(2)
au bufwritepost *.js silent !standard --fix %
