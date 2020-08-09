if exists('b:java_ftplugin')
  finish
endif
let b:java_ftplugin = 1
:call SetTabs(4)
:iabbrev ??? throw new UnsupportedOperationException();
:iabbrev psfs public static final String ;<Esc>hi
:iabbrev pf public final;<Esc>ha
:iabbrev pfs public final String;<Esc>ha
:iabbrev pfb public final boolean;<Esc>ha
:iabbrev pfi public final int;<Esc>ha
:iabbrev pfl public final long;<Esc>ha
:iabbrev pfc public final class {<cr>}<Esc>kk$ha
:iabbrev sout System.out.println();<esc>hi
