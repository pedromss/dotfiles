function! Safe(fname, l)
  let t = type(a:l)
  if v:t_list
    let new_list = deepcopy(a:l)
    return function(a:fname, [new_list])
  elseif v:t_dict
    " TODO
  else
    echom 'Unsupported type'
    return l
  endif
endfunction

function! Sorted(l)
  return Safe('sort', a:l)()
endfunction

function! Reversed(l)
  return Safe('reverse', a:l)()
endfunction

function! Append(l, val)
  return Safe('add', a:l)(a:val)
endfunction

function! Assoc(l, i, val)
  let new_list = deepcopy(a:l)
  let new_list[a:i] = a:val
  return new_list
endfunction

function! Pop(l, i)
  return Safe('remove', a:l)(a:i)
endfunction

function! Mapped(fn, l)
  return Safe('map', a:l)(string(a:fn) . '(v:val)')
endfunction

function! Filtered(fn, l)
  return Safe('filter', a:l)(string(a:fn) . '(v:val)')
endfunction

function! Removed(fn, l)
  return Safe('filter', a:l)('!' . string(a:fn) . '(v:val)')
endfunction

