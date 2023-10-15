let mapleader = ','
let localleader = "\\"
syntax on
filetype plugin indent on
set textwidth=80
set path+=**
set wildignore=*.class,**/target/**,**/.idea/**,**/node_modules/**,**/bower_components/**
set wildmenu
set wildchar
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
set number
set switchbuf=usetab
set backspace=2 
set encoding=utf-8
set scrolloff=3
set hlsearch 
set incsearch 
set cindent
set relativenumber

nnoremap / /\v
nnoremap ? ?\v
"nnoremap <esc> :noh<CR>
nnoremap <space> viw
nnoremap cm :match<cr>
nnoremap <localleader>ev :split $HOME/.vimrc<CR>
nnoremap <s-d> yyp
inoremap jk <esc>
nnoremap <S-C> :bd<CR>
nnoremap <S-Q> :bd!<CR>

