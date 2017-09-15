:cd ~/

set number
set switchbuf=usetab
set backspace=2 " make backspace work like most other apps
set encoding=utf-8
set scrolloff=3
set hlsearch " highlight search words
set incsearch " search as you type
set cindent " indents more if inside brackets
set relativenumber
let mapleader = ','

set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

inoremap <C-Space> <C-x><C-o>

" Searching
nnoremap <Esc> :noh<CR>
nnoremap <

" For local replace
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" VIM-PLUG
if has("gui_win32") 
  call plug#begin('~/vimfiles/plugged')
else
  call plug#begin('~/.vim/plugged')
endif
Plug 'christoomey/vim-titlecase'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'valloric/youcompleteme'
Plug 'pangloss/vim-javascript'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-markdown'
Plug 'ensime/ensime-vim'
Plug 'derekwyatt/vim-scala'
Plug 'marijnh/tern_for_vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'https://github.com/heavenshell/vim-jsdoc.git'
Plug 'maksimr/vim-jsbeautify'
Plug 'alvan/vim-closetag'
Plug 'https://github.com/vim-latex/vim-latex.git'
Plug 'vimwiki/vimwiki'
call plug#end()

" FONTS AND TEXT
if has('gui_running')
  if has('gui_win32')
    set guifont=Consolas:h11:cANSI
  else
    set guifont=Monaco\ for\ Powerline:h11
	endif
endif

set tabstop=2 " how many columns a tab counts for
set softtabstop=2 " hitting Tab in insert mode will produce the appropriate number of spaces.
set shiftwidth=2 " how many columns text is indented with the reindent operations (<< and >>)
set expandtab " If softtabstop is less than tabstop and expandtab is not set, vim will use a combination of tabs and spaces to make up the desired spacing. If softtabstop equals tabstop and expandtab is not set, vim will always use tabs. When expandtab is set, vim will always use the appropriate number of spaces.

" COLORS
:colorscheme vimbrains

" RELOAD
noremap <F2> :tabedit $MYVIMRC<CR>
noremap <F9> :source $MYVIMRC<CR>
noremap <m-F3> :NERDTreeToggle ~/repos<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>:runtime! plugin/settings/*<CR>:redraw<CR>:echo $MYVIMRC 'reloaded'<CR>

" Utility
nnoremap <D-d> yyp

" 
" Line movement
nnoremap ˚ :m-2<CR> 
nnoremap ∆ :m+1<CR> 

" ScrollCollor
map <silent><S-F4> :NEXTCOLOR<cr> 
map <silent><S-F5> :PREVCOLOR<cr>

syntax on
filetype plugin indent on

" Buffers - explore/next/previous: Alt-F12, F12, Shift-F12.
nnoremap <silent> <M-F12> :BufExplorer<CR>
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <F4> :buffers<CR>:tabedit #
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <S-C> :bd<CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['closure compiler', 'eslint', 'flow']
let g:syntastic_scala_checkers = ['scalac', 'scalastyle']

" Vim AIRLINE
let g:airline_powerline_fonts = 1


" Vim-Javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" Easy motion
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Finding files
set path+=** 
set wildignore=*.class,**/target/**,**/.idea/**,**/node_modules/**,**/bower_components/**
set wildmenu
set tags+=.git/tags

command! MakeTags !ctags -R . --exclude=.git --exclude=bower_components --exclude=node_modules --exclude=dist --exclude=build

" Ensime
autocmd BufWritePost *.scala silent :EnTypeCheck
nnoremap <localleader>t :EnTypeCheck<CR>
au FileType scala nnoremap <localleader>df :EnDeclaration<CR>
au FileType scala nnoremap <localleader>dhf :EnDeclarationSplit<CR>
au FileType scala nnoremap <localleader>dvf :EnDeclarationSplit v<CR>
au FileType scala nnoremap <localleader>db :EnDocBrowse<CR>

" JsDoc
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1

au FileType javascript nnoremap <Leader>td :TernDef<CR>
au FileType javascript nnoremap <Leader>tp :TernDefPreview<CR>
au FileType javascript nnoremap <Leader>ts :TernDefSplit<CR>
au FileType javascript nnoremap <Leader>tT :TernDefTab<CR>
au FileType javascript nnoremap <Leader>tD :TernDoc<CR>
au FileType javascript nnoremap <Leader>tbD :TernDocBrowse<CR>
au FileType javascript nnoremap <Leader>tR :TernRefs<CR>
au FileType javascript nnoremap <Leader>tr :TernRename<CR>
au FileType javascript nnoremap <Leader>tt :TernType<CR>

" js-beautify
map <c-f> :call JsBeautify()<cr>
"autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
"" for json
"autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
"" for jsx
"autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
"" for html
"autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
"" for css or scss
"autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" ENSIME
autocmd BufWritePost *.scala silent :EnTypeCheck

" LaTeX Suite
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-y>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Vimwiki
let g:vimwiki_list = [{ 'auto_toc': 1, 'list_margin': 2}]
let g:vimwiki_auto_checkbox=1
let g:vimwiki_list_ignore_newline=0

:map <Leader>tt <Plug>VimwikiToggleListItem

" File finding
"let g:fuf_file_exclud = '\.o$|\.exe$|\.bak$|\.swp$|\.class$'
