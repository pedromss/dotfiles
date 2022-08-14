" Things fzf.vim is missing, but might just be personal taste
command! -complete=dir -nargs=* Oplu call fzf#vim#files('~/dotfiles/.vim/plugin', fzf#vim#with_preview(), 1)
command! -complete=dir -nargs=* Oftp call fzf#vim#files('~/dotfiles/.vim/ftplugin', fzf#vim#with_preview(), 1)
command! -complete=dir -nargs=* Oftd call fzf#vim#files('~/dotfiles/.vim/ftdetect', fzf#vim#with_preview(), 1)

command! -bang -nargs=* AgI call fzf#vim#ag(<q-args>, '--hidden', fzf#vim#with_preview(), <bang>0)

