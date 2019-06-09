" Functions... -------------------- {{{
function! SetTabs(amount)
  let &l:tabstop = a:amount
  let &l:shiftwidth = a:amount
  let &l:softtabstop = a:amount
endfunction

"function! AddShebang()
  "" TODO test for the presence of the shebang already
  "" TODO dont use marks when it is a new file
  "if &filetype !=? 'sh'
    "echo 'Filetype is ' . &filetype . ' not adding the shebang line'
  "else
    "let shebang = '#!/usr/bin/env bash'
    ":execute "normal! mtggI" . shebang "\<esc>o\<esc>`t"
  "endif
"endfunction

function! CloseGoErrors() 
  let buffers = filter(range(1, bufnr('$')), 'bufexists(v:val)')
  echo buffers
endfunction

" }}}
" Basic settings -------------------- {{{
if has('gui_running')
  if has('gui_win32')
    set guifont=Consolas:h11:cANSI
  else
    set guifont=Monaco\ for\ Powerline:h11
  endif
endif
let mapleader = ','
let localleader = "\\"
":colorscheme vimbrains
":colorscheme neodark
":colorscheme allomancer
:colorscheme escuro
":colorscheme oldbook
":colorscheme seoul256
":colorscheme srcery
syntax on
filetype plugin indent on
set textwidth=80
set path+=**
set wildignore=*.class,**/target/**,**/.idea/**,**/node_modules/**,**/bower_components/**
set wildmenu
set tags+=.git/tags
set tabstop=2 " how many columns a tab counts for
set softtabstop=2 " hitting Tab in insert mode will produce the appropriate number of spaces.
set shiftwidth=2 " how many columns text is indented with the reindent operations (<< and >>)
set expandtab " If softtabstop is less than tabstop and expandtab is not set, vim will use a combination of tabs and spaces to make up the desired spacing. If softtabstop equals tabstop and expandtab is not set, vim will always use tabs. When expandtab is set, vim will always use the appropriate number of spaces.
" SYNTASTIC
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set number
set switchbuf=usetab
set backspace=2 " make backspace work like most other apps
set encoding=utf-8
set scrolloff=3
set hlsearch " highlight search words
set incsearch " search as you type
set cindent " indents more if inside brackets
set relativenumber
set list
set listchars=tab:▸·,trail:·,eol:↵" Show tabs as !<dot> and spaces as <dot>
set cul " highlight current line
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END
set splitbelow
set splitright
" }}}
" Commands -------------------- {{{
command! MakeTags !ctags -R . --exclude=plugins --exclude=plugged --exclude=.git --exclude=bower_components --exclude=node_modules --exclude=dist --exclude=build
" }}}
" Plugins -------------------- {{{
let g:ale_emit_conflict_warnings = 0
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
if has('gui_win32')
  call plug#begin('~/vimfiles/plugged')
else
  call plug#begin('~/.dotfiles/vim/.vim/plugged')
endif
" FZF / Ctrlp for file navigation
if executable('fzf')
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
else
  Plug 'ctrlpvim/ctrlp.vim'
endif
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

"Plug 'svermeulen/vim-cutlass'
"Plug 'svermeulen/vim-yoink'
"Plug 'svermeulen/vim-subversive'

Plug 'Chiel92/vim-autoformat'
"Plug 'KeitaNakamura/neodark.vim'
"Plug 'airblade/vim-rooter'
Plug 'alvan/vim-closetag', { 'for': 'html' }
"Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'bling/vim-airline'
Plug 'christoomey/vim-titlecase'
"Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'flazz/vim-colorschemes'
"Plug 'hashivim/vim-terraform'
"Plug 'honza/vim-snippets'
"Plug 'heavenshell/vim-jsdoc.git', { 'for': 'javascript' }
Plug 'vim-latex/vim-latex'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'keith/investigate.vim'
Plug 'leafgarland/typescript-vim'
Plug 'majutsushi/tagbar'
Plug 'martinda/Jenkinsfile-vim-syntax', { 'for': 'Jenkinsfile' }
Plug 'mhinz/vim-signify'
Plug 'mileszs/ack.vim'
"Plug 'moby/moby'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rdolgushin/groovy.vim', { 'for': 'groovy' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'shime/vim-livedown', { 'for': 'markdown' }
Plug 'tfnico/vim-gradle'
Plug 'udalov/kotlin-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
if has('nvim')
  Plug 'Shougo/neco-vim', { 'for': 'go' }
  Plug 'zchee/deoplete-clang'
  Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make'}
  Plug 'mdempsky/gocode', { 'rtp': 'nvim' }
  Plug 'mhartington/nvim-typescript', { 'for': 'typescript' }
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
endif

" TODO too powerful, need to read
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'neomake/neomake'
endif

" TODO are these really necessary?!
Plug 'jiangmiao/auto-pairs'
call plug#end()
" }}}
" Gui settings -------------------- {{{
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
" }}}
" Latex settings -------------------- {{{
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
" }}}
" Mappings -------------------- {{{
" Vim cutlass mappings -------------------- {{{
"nnoremap x d
"xnoremap x d
"nnoremap xx dd
"nnoremap X D
"nnoremap cl cl<Esc>
" }}}
" Vim yoink mappings -------------------- {{{
"nmap <c-n> <plug>(YoinkPostPasteSwapForward)
"nmap <c-p> <plug>(YoinkPostPasteSwapBack)
"nmap p <plug>(YoinkPaste_p)
"nmap P <plug>(YoinkPaste_P)
"nmap [y <plug>(YoinkRotateBack)
"nmap ]y <plug>(YoinkRotateForward)
" }}}
" Vim Subversive -------------------- {{{
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)
" }}}
" Fugitive VIM mappings -------------------- {{{
nnoremap <localleader>fgb :Gblame<CR>
nnoremap <localleader>fgs :Gstatus<CR>
nnoremap <localleader>fgc :Gcommit %<CR>
" }}}
" Navigation -------------------- {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}
" General mappings -------------------- {{{
nnoremap <leader>g :silent :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
if has('nvim')
  nnoremap <F2> :below 20split \| :terminal<CR>
endif
inoremap <f1> <Esc>:w<cr>
nnoremap <f1> :w<cr>
inoremap jn <Esc>o
inoremap jI <Esc>^i
inoremap jA <Esc>g_a
nnoremap soc :echo "below"<cr>
nnoremap / /\v\c
nnoremap ? ?\v\c
"nnoremap <leader>w :match TWS /\v $/<cr>
nnoremap L :b#<cr>
nnoremap <space> viw
nnoremap <Esc> :noh<CR>
nnoremap cm :match<cr>
nnoremap <m-k> :m-2<CR>
nnoremap <m-j> :m+0<CR>
nnoremap <leader>ev :vsplit $HOME/.vimrc<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>
nnoremap <localleader>sv :source $MYVIMRC<CR>
nnoremap <s-d> yyp
nnoremap <localleader>t :NERDTreeToggle<CR>
nnoremap <leader>F :Files<CR>
nnoremap <leader>G :GFiles<Cr>
inoremap jk <esc>
noremap <leader>af :Autoformat<CR>
noremap <localleader>nf :set nofoldenable!<CR>
noremap <C-n> :cn<CR>
noremap <C-m> :cp<CR>

" edit a new buffer in the current pane event with changes
nnoremap <leader>enn :ene<cr>
" edit a new buffer in the current pane if no changes
nnoremap <leader>enf :ene!<cr>

nnoremap <f10> :set readonly!<cr>

"au BufWrite * :Autoformat
" }}}
" Livedown mappings -------------------- {{{
nnoremap <localleader>ldp :LivedownPreview<CR>
nnoremap <localleader>ldk :LivedownKill<CR>
nnoremap <localleader>ldt :LivedownToggle<CR>
" }}}
" Vim Diff Mappings -------------------- {{{
nnoremap <localleader>gl :diffg LO
nnoremap <localleader>gb :diffg BA
nnoremap <localleader>gr :diffg RE
" }}}
" Buffer mappings -------------------- {{{
nnoremap <silent> <M-F12> :BufExplorer<CR>
nnoremap <silent> <F11> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>
nnoremap <leader>bte :buffers<CR>:tabedit #
nnoremap B :buffers<CR>:buffer<Space>
nnoremap <S-C> :bd<CR>
nnoremap <S-Q> :bd!<CR>
" }}}
" Go mappings -------------------- {{{
augroup go_mappings
  autocmd!
  au FileType go noremap gob :GoBuild<CR>
  au FileType go noremap gots :GoTest<CR>
  au FileType go noremap gota :GoTest ./...<CR>
  au FileType go noremap goft :GoTestFunc<CR>
  au FileType go noremap goi :GoInstall<CR>
  au FileType go noremap gomi :GoImport
  au FileType go noremap goma :GoImportAs
  au FileType go noremap gor :GoRun<CR>
  au FileType go noremap gode :GoDef<CR>
  au FileType go noremap godo :GoDoc<CR>
augroup END
" }}}
" Fzf mappings -------------------- {{{
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
" }}}
" Titlecase mappings -------------------- {{{
" TODO review this plugins config
nmap <leader>gt <Plug>Titlecase
vmap <leader>gt <Plug>Titlecase
nmap <leader>gT <Plug>TitlecaseLine
" }}}
" Vimwiki mappings -------------------- {{{
augroup vimwiki_mappings
  autocmd!
  au FileType vimwiki map <leader>tt <Plug>VimwikiToggleListItem
  au FileType vimwiki map <leader>wth :Vimwiki2HTML<CR>
  au FileType vimwiki map <leader>wthb :Vimwiki2HTMLBrowse<CR>
augroup END
" }}}
" Scrollcolor mappings -------------------- {{{
map <silent><S-F4> :NEXTCOLOR<cr>
map <silent><S-F5> :PREVCOLOR<cr>
" }}}
" Easymotion mappings -------------------- {{{
"map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
"" MOVE TO LINE
"map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
"" MOVE TO WORD
"map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" }}}
" Ensime mappings -------------------- {{{
"augroup ensime_mappings
"autocmd!
"autocmd BufWritePost *.scala silent :EnTypeCheck
"au FileType scala nnoremap <localleader>et :EnTypeCheck<CR>
"au FileType scala nnoremap <localleader>df :EnDeclaration<CR>
"au FileType scala nnoremap <localleader>dhf :EnDeclarationSplit<CR>
"au FileType scala nnoremap <localleader>dvf :EnDeclarationSplit v<CR>
"au FileType scala nnoremap <localleader>db :EnDocBrowse<CR>
"augroup END
" }}}
" Tern mappings -------------------- {{{
augroup tern_mappings
  autocmd!
  au FileType javascript,typescript nnoremap <Leader>td :TernDef<CR>
  au FileType javascript,typescript nnoremap <Leader>tp :TernDefPreview<CR>
  au FileType javascript,typescript nnoremap <Leader>ts :TernDefSplit<CR>
  au FileType javascript,typescript nnoremap <Leader>tT :TernDefTab<CR>
  au FileType javascript,typescript nnoremap <Leader>tD :TernDoc<CR>
  au FileType javascript,typescript nnoremap <Leader>tbD :TernDocBrowse<CR>
  au FileType javascript,typescript nnoremap <Leader>tR :TernRefs<CR>
  au FileType javascript,typescript nnoremap <Leader>tr :TernRename<CR>
  au FileType javascript,typescript nnoremap <Leader>tt :TernType<CR>
augroup END
" }}}
" Quick fix file mappings -------------------- {{{
augroup filetype_mappings_quickfix
  autocmd!
  autocmd FileType qf noremap <localleader>n :cnext<cr>
  autocmd FileType qf noremap <localleader>p :cprevious<cr>
  autocmd FileType qf noremap <localleader>cc :ccl<cr>
augroup END
" }}}
" Vim file mappings -------------------- {{{
augroup filetype_mappings_vim
  autocmd!
  autocmd FileType vim nnoremap soc :w \| :so %<cr>
augroup END
" }}}
" Java file mappings -------------------- {{{
augroup filetype_mappings_java
  autocmd!
  "autocmd FileType java nnoremap <localleader>ji :JavaImport<cr>
  autocmd FileType java nnoremap <localleader>jc :JavaCorrect<cr>
  autocmd FileType java nnoremap <localleader>jr :JavaRename<cr>
  autocmd FileType java nnoremap <localleader>jd :JavaDocPreview<cr>
  "autocmd FileType java nnoremap <localleader>jc :JavaConstructor<cr>
augroup END
" }}}
" Terminal variables -------------------- {{{
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <leader>cq <Esc>:q!<CR>
endif
" }}}
" VIm colorscheme switcher -------------------- {{{
noremap <F8> :NextColorScheme<cr>
noremap <F9> :PrevColorScheme<cr>
" }}}
" Tagbar mappings -------------------- {{{
nmap <leader>tb :TagbarToggle<CR>
" }}}
" }}}
" Variables -------------------- {{{
" vim-go variables -------------------- {{{
let g:go_fold_enable = ['varconst','block','import','comment', ]
let g:go_highlight_extra_types = 1
let g:go_highlight_function_parameters = 0
let g:go_highlight_function_calls = 0
let g:go_highlight_types = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_assignments = 1
" }}}
" VIM yoink variables -------------------- {{{
let g:yoinkIncludeDeleteOperations = 1
" }}}
" Signify -------------------- {{{
let g:signify_vcs_list = [ 'git']
" }}}
" AutoFormat variables -------------------- {{{
"let g:formatterpath = ['/usr/local/bin/jq']
let g:autoformat_verbosemode=0
" }}}
" Livedown variables -------------------- {{{
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 1
" should the browser window pop-up upon previewing
let g:livedown_open = 1
" the port on which Livedown server will run
let g:livedown_port = 1337
" the browser to use
let g:livedown_browser = "chrome"
" }}}
" Ag variables -------------------- {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" }}}
" Netrw variables -------------------- {{{
let g:netrw_banner = 0
let g:netrw_altv = 1 " open splits to the right
let g:netrw_liststyle = 3 " tree view
" }}}
" Scalafmt variables -------------------- {{{
let g:formatdef_scalafmt = "'scalafmt --stdin'"
let g:formatters_scala = ['scalafmt']
" }}}
" Vim makrdown variables -------------------- {{{
"let vim_markdown_preview_toggle=2
"let vim_markdown_preview_github=0
"let vim_markdown_preview_browser='Safari'
" }}}
" Deoplete TernJS variables -------------------- {{{
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  " DEOPLETE TERN
  " Set bin if you have many instalations
  "let g:deoplete#sources#ternjs#tern_bin = '/path/to/tern_bin'
  let g:deoplete#sources#ternjs#timeout = 1

  " Whether to include the types of the completions in the result data. Default: 0
  let g:deoplete#sources#ternjs#types = 1

  " Whether to include the distance (in scopes for variables, in prototypes for
  " properties) between the completions and the origin position in the result
  " data. Default: 0
  let g:deoplete#sources#ternjs#depths = 1

  " Whether to include documentation strings (if found) in the result data.
  " Default: 0
  let g:deoplete#sources#ternjs#docs = 1

  " When on, only completions that match the current word at the given point will
  " be returned. Turn this off to get all results, so that you can filter on the
  " client side. Default: 1
  let g:deoplete#sources#ternjs#filter = 0

  " Whether to use a case-insensitive compare between the current word and
  " potential completions. Default 0
  let g:deoplete#sources#ternjs#case_insensitive = 1

  " When completing a property and no completions are found, Tern will use some
  " heuristics to try and return some properties anyway. Set this to 0 to
  " turn that off. Default: 1
  let g:deoplete#sources#ternjs#guess = 0

  " Determines whether the result set will be sorted. Default: 1
  let g:deoplete#sources#ternjs#sort = 0

  " When disabled, only the text before the given position is considered part of
  " the w_rd. When enabled (the default), the whole variable namn that the cursor
  " is on will be included. Default: 1
  let g:deoplete#sources#ternjs#expand_word_forward = 0

  " Whether to ignore the properties of Object.prototype unless they have been
  " spelled out by at least to characters. Default: 1
  let g:deoplete#sources#ternjs#omit_object_prototype = 0

  " Whether to include JavaScript keywords when completing something that is not
  " a property. Default: 0
  let g:deoplete#sources#ternjs#include_keywords = 1

  " If completions should be returned when inside a literal. Default: 1
  let g:deoplete#sources#ternjs#in_literal = 0
  "Add extra filetypes
  let g:deoplete#sources#ternjs#filetypes = [
        \ 'jsx',
        \ 'javascript.jsx',
        \ 'vue',
        \ '...'
        \ ]
  let g:deoplete#sources#clang#libclang_path='/usr/local/Cellar/llvm/5.0.0/lib/libclang.dylib'
  let g:deoplete#sources#clang#clang_header='/usr/local/Cellar/cmake/' " path/to/lib/clang
  " DEOPLETE-GO
  let g:deoplete#sources#go#gocode_binary=$GOPATH.'/bin/gocode'

  augroup deoplete_aus
    autocmd!
    au FileType let g:deoplete#enable_at_startup = 1
  augroup END
endif
" }}}
" Tern variables -------------------- {{{
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
" }}}
" Titlecase variables -------------------- {{{
let g:titlecase_map_keys = 0
" }}}
" JsDoc variables -------------------- {{{
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
" }}}
" Airline variables -------------------- {{{
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_powerline_fonts = 1
let g:airline_theme='wombat'
" }}}
" Vim-javascript variables -------------------- {{{
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
" }}}
" Vim-latex variables -------------------- {{{
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
" }}}
" UltiSnips variables -------------------- {{{
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = '<s-tab>'
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetsDir = $HOME."/dotfiles/vim/ultisnips"
let g:UltiSnipsSnippetDirectories = [$HOME."/dotfiles/vim/ultisnips"]
" }}}
" Vimwiki variables -------------------- {{{
let g:vimwiki_list = [{ 'auto_toc': 1, 'list_margin': 2}]
let g:vimwiki_auto_checkbox=1
let g:vimwiki_list_ignore_newline=0
" }}}
" Git slides settings -------------------- {{{
let g:gitslides_use_custom_mappings = 0
" }}}
" }}}
" Abbreviations -------------------- {{{
" General abbr -------------------- {{{
augroup general_abbreviations
  autocmd!
  :iabbrev adn and
  :iabbrev treu true
  :iabbrev flase false
augroup END
" }}}
" Java abbr -------------------- {{{
augroup abbreviations_java
  autocmd!
  autocmd FileType java :iabbrev ??? throw new UnsupportedOperationException();
  autocmd FileType java :iabbrev psfs public static final String ;<Esc>hi
  autocmd FileType java :iabbrev pf public final;<Esc>ha
  autocmd FileType java :iabbrev pfs public final String;<Esc>ha
  autocmd FileType java :iabbrev pfb public final boolean;<Esc>ha
  autocmd FileType java :iabbrev pfi public final int;<Esc>ha
  autocmd FileType java :iabbrev pfl public final long;<Esc>ha
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType java :iabbrev pfc public final class {<cr>}<Esc>kk$ha
  autocmd FileType java :iabbrev sout System.out.println();<esc>hi
augroup END
" }}}
" }}}
" Filetype settings -------------------- {{{
" Scala file settings -------------------- {{{
augroup scala_auto_cmds
  autocmd!
  au FileType scala :call SetTabs(2)
  "au FileType scala silent :EnTypeCheck
augroup END
" }}}
" Go file settings -------------------- {{{
augroup go_aus
  autocmd!
  au FileType go :call SetTabs(4)
  au FileType go :set foldmethod=syntax
augroup END
" }}}
" Go templates -------------------- {{{
augroup go_templates_settings
  autocmd!
  au FileType gohtmltmpl
  au FileType gohtmltmpl set noexpandtab
  au FileType gohtmltmpl set tabstop=4
  au FileType gohtmltmpl set softtabstop=4
  au FileType gohtmltmpl set shiftwidth=4
augroup END
" }}}
" Java file settings -------------------- {{{
augroup java_aus
  autocmd!
  au FileType java :call SetTabs(4)
augroup END
" }}}
" Javascript file settings -------------------- {{{
augroup js_aus
  autocmd!
  au FileType javascript :call SetTabs(2)
  au bufwritepost *.js silent !standard --fix %
  set autoread
augroup END
" }}}
" Typescript file settings -------------------- {{{
augroup ts_aus
  autocmd!
  au FileType typescript :call SetTabs(4)
augroup END
" }}}
" Bash file settings -------------------- {{{
augroup filetype_bash
  autocmd!
  au FileType sh :normal gg=G
  au FileType sh :call SetTabs(2)
  au FileType sh :set fo-=t " remove line wrap if textwidth is exceeded
augroup END
" }}}
" Markdown file settings -------------------- {{{
augroup filetype_markdown
  au FileType markdown :set fo-=t " remove line wrap if textwidth is exceeded
augroup END
" }}}
" HTML file settings -------------------- {{{
augroup filetype_html
  autocmd!
  au FileType html setlocal nowrap
  au FileType html :call SetTabs(2)
augroup END
"}}}
" Json file settings -------------------- {{{
augroup filetype_json
  autocmd!
  au FileType json nnoremap <buffer> <leader>af :%!jq '.'<CR>
augroup END
" }}}
" Groovy file settings -------------------- {{{
augroup groovy_aus
  autocmd!
  au FileType groovy :call SetTabs(4)
augroup END
" }}}
" Vimscript file settings ------------------------------ {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim :cal SetTabs(2)
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim nnoremap <leader>mf o" Fold description <esc>20a-<esc>a {{{<cr><cr>}}}<esc>kcc
augroup END
" }}}
" }}}
" Operator pending movements -------------------- {{{
" Parentheses -------------------- {{{
onoremap p i(
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
" }}}
" Double quotes -------------------- {{{
onoremap q i"
onoremap in" :<c-u>normal! f"vi"<cr>
onoremap il" :<c-u>normal! F"vi"<cr>
" }}}
" Curly braces -------------------- {{{
onoremap a i{
" }}}
" Single quotes -------------------- {{{
onoremap in' :<c-u>normal! f'vi'<cr>
onoremap il' :<c-u>normal! F'vi'<cr>
" }}}
" Markdown -------------------- {{{
onoremap ih :<c-u>execute "normal! ?^==\\+$\\\\|^--\\+$\r:nohlsearch\rkvg_"<cr>
" }}}
" Hightlight groups -------------------- {{{
highlight TWS ctermbg=red guibg=red
" }}}
" Neomake Filetype makers -------------------- {{{
if has('nvim')
  " Java makers -------------------- {{{
  augroup makers_java
    autocmd!
    autocmd Filetype java let g:neomake_java_enabled_makers = [ 'gradle', 'mvn' ]
    autocmd Filetype java let b:neomake_java_enabled_makers = [ 'gradle', 'mvn' ]
  augroup END
  " }}}
  " Scala makers -------------------- {{{
  augroup makers_scala
    autocmd!
    autocmd Filetype scala let g:neomake_scala_enabled_makers = [ 'sbt', 'scalac' ]
    autocmd Filetype scala let b:neomake_scala_enabled_makers = [ 'sbt', 'scalac' ]
  augroup END
  " }}}
  " Vimscript makers -------------------- {{{
  augroup makers_vimscript
    autocmd!
    autocmd Filetype vim let g:neomake_vim_enabled_makers = [ 'vint' ]
    autocmd Filetype vim let b:neomake_vim_enabled_makers = [ 'vint' ]
  augroup END
  " }}}
  call neomake#configure#automake('w')
endif
" }}}
" Split Navigation -------------------- {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}
