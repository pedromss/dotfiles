onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in" :<c-u>normal! f"vi"<cr>
onoremap il" :<c-u>normal! F"vi"<cr>
onoremap in` :<c-u>normal! f`vi`<cr>
onoremap il` :<c-u>normal! F`vi`<cr>
onoremap in' :<c-u>normal! f'vi'<cr>
onoremap il' :<c-u>normal! F'vi'<cr>
" Remove param
" Move back to the first '(' or ',' then visually selects until the first ',' or
" ')' and applies the operator. Commas are untouched
" 
" TODO this still leaves the commas, should think of a way to delete the commas
" TODO still leaves the search highlighted
onoremap n, :execute "normal! ?\\v\\c(,\|\\(\\|[)\rlv/\\v\\c(,\|\\)\\|])\rh"<cr>
