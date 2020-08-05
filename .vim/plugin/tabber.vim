function! SetTabs(amount)
  let &l:tabstop = a:amount
  let &l:shiftwidth = a:amount
  let &l:softtabstop = a:amount
endfunction
