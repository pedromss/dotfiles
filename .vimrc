set encoding=utf-8
scriptencoding uft8
" Functions... -------------------- {{{
function! LoadColorScheme(scheme)
  if filereadable(expand('~/dotfiles/.vim/colors/' . a:scheme . '.vim'))
    execute ':colorscheme ' . a:scheme
  endif
endfunction
" }}}
" Basic settings -------------------- {{{
let mapleader = ','
let localleader = "\\"
call LoadColorScheme('gruvbox')
set background=dark
syntax on
filetype plugin indent on
set textwidth=80
set path+=**
set wildignore=*.class,**/target/**,**/.idea/**,**/node_modules/**,**/bower_components/**
set wildmenu
set tags+=.git/tags
set cursorcolumn
set cursorline
set tabstop=2 " how many columns a tab counts for
set softtabstop=2 " hitting Tab in insert mode will produce the appropriate number of spaces.
set shiftwidth=2 " how many columns text is indented with the reindent operations (<< and >>)
set expandtab
set statusline+=%#warningmsg#
set statusline+=%*
set number
set switchbuf=usetab
set backspace=2 " make backspace work like most other apps
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
command! MakeTags !ctags --tag-relative=yes --sort=yes -R -f .git/tags --exclude=bin --exclude=xdg --exclude=build --exclude=plugins --exclude=plugged --exclude=.git --exclude=bower_components --exclude=node_modules --exclude=dist --exclude=build .
" }}}
" Plugins -------------------- {{{
call plug#begin('~/dotfiles/.vim/plugged')
" FZF / Ctrlp for file navigation
if executable('fzf')
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  "else
  "Plug 'ctrlpvim/ctrlp.vim'
endif
Plug 'neoclide/jsonc.vim'
Plug 'yuezk/vim-js', { 'for': 'javascript' }
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': 'javascript' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'junegunn/goyo.vim'
Plug 'yegappan/mru'
Plug 'jlanzarotta/bufexplorer'
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-cucumber'
Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-subversive'
Plug 'Chiel92/vim-autoformat'
Plug 'alvan/vim-closetag', { 'for': 'html' }
Plug 'bling/vim-airline'
Plug 'christoomey/vim-titlecase'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'flazz/vim-colorschemes'
Plug 'vim-latex/vim-latex'
Plug 'majutsushi/tagbar'
Plug 'martinda/Jenkinsfile-vim-syntax', { 'for': 'Jenkinsfile' }
Plug 'mhinz/vim-signify'
Plug 'mileszs/ack.vim'
Plug 'modille/groovy.vim', { 'for': 'groovy' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'shime/vim-livedown', { 'for': 'markdown' }
Plug 'tfnico/vim-gradle'
Plug 'udalov/kotlin-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
if has('python') || has('python3')
  Plug 'SirVer/ultisnips'
endif
call plug#end()
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
" ALE Mappings -------------------- {{{
nmap <silent> <localleader>ap <Plug>(ale_previous_wrap)
nmap <silent> <localleader>an <Plug>(ale_next_wrap)
nnoremap <localleader>al :ALELint<cr>
nnoremap <localleader>af :ALEFix<cr>
" }}}
" Goyo mappings -------------------- {{{
nnoremap <F3> :Goyo<cr>
" }}}
" MRU mappings -------------------- {{{
nnoremap <leader>mr :MRU<cr>
" }}}
" Tabularize mappings -------------------- {{{
vnoremap <localleader>qw= :'<,'>Tabularize /=<cr>
vnoremap <localleader>qw, :'<,'>Tabularize /,<cr>
vnoremap <localleader>qw :'<,'>Tabularize /
nnoremap <localleader>qw= ggVG:'<,'>Tabularize /=<cr>
nnoremap <localleader>qw, ggVG:'<,'>Tabularize /,<cr>
nnoremap <localleader>qw ggVG:'<,'>Tabularize /
" }}}
" Vim cutlass mappings -------------------- {{{
nnoremap x d
xnoremap x d
nnoremap xx dd
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
nnoremap <F4> :Gblame<CR>
"nnoremap <localleader>fgs :Gstatus<CR>
nnoremap <localleader>fgc :Gcommit %<CR>
" }}}
" Panes -------------------- {{{
nnoremap <C-v><localleader> :vsplit ene<cr>
nnoremap <C-v>- :split ene<cr>
" }}}
" Navigation -------------------- {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}
" General mappings -------------------- {{{
nnoremap <silent> <localleader>cc :cclose<cr> :lclose<cr>
nnoremap <leader>zf f{v%zf<esc>
nnoremap <leader>zF F{v%zf<esc>
nnoremap <leader>g :silent :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
if has('nvim')
  nnoremap <F2> :below 20split \| :terminal<CR>
endif
nnoremap <leader>qe a<cr><esc>
nnoremap <leader>qw i<cr><esc>
inoremap <C-s> <Esc>:w<cr>
nnoremap <C-s> :w<cr>
inoremap <C-u> <Esc>xi
inoremap <C-l> <Esc>lxi
" Commodities, maybe this can be improved with operator pending movements
" but then it won't work in IDEA as only the vim default operator pending
" movements are supported
inoremap jF) <Esc>f)i
inoremap jF} <Esc>f}i
inoremap jF, <Esc>f,i
inoremap jB( <Esc>F(i
inoremap jB, <Esc>F,i
inoremap jB{ <Esc>F{i
inoremap jZ) <Esc>mpf)dl`pa
inoremap jZ, <Esc>mpf,dl`pa
inoremap jQ  <Esc>f{%O
inoremap jR2 <Esc>20a
inoremap jR5 <Esc>50a
inoremap jK <Esc>:m-2<cr>i
inoremap jJ <Esc>:m+1<cr>i
inoremap jU <Esc>ui
nnoremap <m-k> :m-2<CR>
nnoremap <m-j> :m+1<CR>
" ==================================================
inoremap jn <Esc>o
inoremap jI <Esc>^i
inoremap jA <Esc>g_a
inoremap jW <Esc>wa
inoremap jE <Esc>ea
inoremap jO <Esc>O
inoremap <m-j> <down>
inoremap <m-k> <up>
inoremap <m-h> <left>
inoremap <m-l> <right>
nnoremap <Leader>sr :match TWS /\<<C-r><C-w>\>/<cr>:%s/\<<C-r><C-w>\>/
nnoremap / /\v\c
nnoremap ? ?\v\c
nnoremap L :b#<cr>
nnoremap <space> viw
nnoremap <Esc> :noh<CR>:mat none<cr>
nnoremap cm :match TWS /\<<C-r><C-w>\>/<cr>
nnoremap <m-k> :m-2<CR>
nnoremap <m-j> :m+1<CR>
nnoremap <leader>ev :tabnew ~/dotfiles/.vimrc<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>
nnoremap <s-d> :co.<cr>
nnoremap <localleader><localleader>n :NERDTreeToggle<CR>
inoremap jk <esc>l
noremap <leader>af :Autoformat<CR>
noremap <localleader>nf :set nofoldenable!<CR>
noremap <C-n> :cn<CR>
noremap <C-m> :cp<CR>
" edit a new buffer in the current pane even with changes
nnoremap <leader>enn :ene<cr>
" edit a new buffer in the current pane if no changes
nnoremap <leader>enf :ene!<cr>
"au BufWrite * :Autoformat
" }}}
" Livedown mappings -------------------- {{{
nnoremap <localleader>ldp :LivedownPreview<CR>
nnoremap <localleader>ldk :LivedownKill<CR>
nnoremap <localleader>ldt :LivedownToggle<CR>
" }}}
" Vim Diff Mappings -------------------- {{{
nnoremap <localleader>vdl :diffget LOCAL<cr>
nnoremap <localleader>vdb :diffget BASE<cr>
nnoremap <localleader>vdr :diffget REMOTE<cr>
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
  au FileType go nnoremap <localleader>gob :GoBuild<CR>
  au FileType go nnoremap <localleader>gots :GoTest<CR>
  au FileType go nnoremap <localleader>gotf :GoTestFunc<CR>
  au FileType go nnoremap <localleader>goi :GoInstall<CR>
  au FileType go nnoremap <localleader>gode :GoDef<CR>
  au FileType go nnoremap <localleader>godo :GoDoc<CR>
  au FileType go nnoremap <localleader>goc :GoCoverageToggle<cr>
  au FileType go nnoremap <localleader>gom :GoMetaLinter<cr>
  au FileType go nnoremap <localleader>goa :GoAlternate<cr>
augroup END
" }}}
" Fzf mappings -------------------- {{{
" " This is the default extra key bindings
let g:fzf_action = {
      \ 'alt-t': 'tab split',
      \ 'alt-x': 'split',
      \ 'alt-v': 'vsplit' }

"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
if has('nvim') && !exists('g:fzf_layout')
  augroup fzf_no_statusline
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
          \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  augroup end
endif

nnoremap <leader>F :FzfFiles<cr>
nnoremap <leader>G :FzfGFiles<cr>
nnoremap <leader>S :FzfSnippets<cr>
nnoremap <f7> :FzfGFiles?<cr>
nnoremap <leader>B :FzfBuffers<cr>
nnoremap <leader><c-f> :FzfBLines<cr>
nnoremap <leader><c-l> :FzfLines<cr>
nnoremap <leader><c-a> :FzfAg<cr>
nnoremap <leader><c-t> :FzfBTags<cr>
nnoremap <leader>M :FzfMarks<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

let g:fzf_command_prefix = 'Fzf'

" Insert mode completion
imap <c-q><c-f> <plug>(fzf-complete-path)
imap <c-q><c-j> <plug>(fzf-complete-file-ag)
" }}}
" Titlecase mappings -------------------- {{{
" TODO review this plugins config
nmap <localleader>tcw <Plug>Titlecase
vmap <localleader>tcw <Plug>Titlecase
nmap <localleader>tcl <Plug>TitlecaseLine
" }}}
" Vimwiki mappings -------------------- {{{
augroup vimwiki_mappings
  autocmd!
  au FileType vimwiki map <localleader>vwt <Plug>VimwikiToggleListItem
  au FileType vimwiki map <localleader>vwhh :Vimwiki2HTML<CR>
  au FileType vimwiki map <localleader>vwhb :Vimwiki2HTMLBrowse<CR>
augroup END
" }}}
" Easymotion mappings -------------------- {{{
nmap <localleader>emw <Plug>(easymotion-overwin-w)
map <localleader>emj <Plug>(easymotion-j)
map <localleader>emk <Plug>(easymotion-k)
" }}}
" Tern mappings -------------------- {{{
augroup tern_mappings
  autocmd!
  au FileType javascript,typescript nnoremap <localleader>tjd :TernDef<CR>
  au FileType javascript,typescript nnoremap <localleader>tjp :TernDefPreview<CR>
  au FileType javascript,typescript nnoremap <localleader>tjs :TernDefSplit<CR>
  au FileType javascript,typescript nnoremap <localleader>tjT :TernDefTab<CR>
  au FileType javascript,typescript nnoremap <localleader>tjD :TernDoc<CR>
  au FileType javascript,typescript nnoremap <localleader>tjbD :TernDocBrowse<CR>
  au FileType javascript,typescript nnoremap <localleader>tjR :TernRefs<CR>
  au FileType javascript,typescript nnoremap <localleader>tjr :TernRename<CR>
  au FileType javascript,typescript nnoremap <localleader>tjt :TernType<CR>
augroup END
" }}}
" Quick fix file mappings -------------------- {{{
augroup filetype_mappings_quickfix
  autocmd!
  autocmd FileType qf noremap <localleader>n :cnext<cr>
  autocmd FileType qf noremap <localleader>p :cprevious<cr>
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
nmap <localleader><localleader>t :TagbarToggle<CR>
" }}}
" }}}
" Variables -------------------- {{{
" ALE variables -------------------- {{{
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_emit_conflict_warnings = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'javascript': ['eslint'],
      \   'vue': ['eslint'],
      \   'vim': ['vint']
      \}

let g:ale_fixers = {
      \   'javascript': ['eslint']
      \}

let g:ale_fix_on_save = 1
" }}}
" mru variables -------------------- {{{
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'
let MRU_Window_Height = 15
let MRU_Use_Current_Window = 0
let MRU_Auto_Close = 1
" }}}
" Shebang plugin variables -------------------- {{{
"let g:shebanger_shebang_line = '#!/usr/bin/env zsh'
" }}}
" Rust variable -------------------- {{{
let g:rustfmt_autosave = 1
" }}}
" vim-go variables -------------------- {{{
let g:go_fold_enable = ['varconst','block','import','comment', ]
let g:go_highlight_extra_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 0
let g:go_highlight_types = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_assignments = 1
let g:go_code_completion_enabled = 1
let g:go_test_show_name = 1
let g:go_auto_sameids = 0
let g:go_auto_type_info = 1
let g:go_doc_popup_window = 1
let g:go_snippet_engine = 'ultisnips'
let g:go_statusline_duration = 20000
let g:go_metalinter_autosave = 0
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" }}}
" VIM yoink variables -------------------- {{{
let g:yoinkIncludeDeleteOperations = 1
" }}}
" Signify -------------------- {{{
let g:signify_vcs_list = [ 'git']
" }}}
" AutoFormat variables -------------------- {{{
let g:formatterpath = []
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
augroup auto_format_defaults
	autocmd!
  autocmd FileType vim,tex let b:autoformat_autoindent=1
  autocmd FileType vim,tex let b:autoformat_retab=1
  autocmd FileType vim,tex let b:autoformat_remove_trailling_spaces=1
augroup end
let g:autoformat_verbosemode=0
" }}}
" Livedown variables -------------------- {{{
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 0
" should the browser window pop-up upon previewing
let g:livedown_open = 1
" the port on which Livedown server will run
let g:livedown_port = 1337
" the browser to use
let g:livedown_browser = 'firefox'
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
"if has('nvim')
"let g:deoplete#enable_at_startup = 1
"" DEOPLETE TERN
"" Set bin if you have many instalations
""let g:deoplete#sources#ternjs#tern_bin = '/path/to/tern_bin'
"let g:deoplete#sources#ternjs#timeout = 1

"" Whether to include the types of the completions in the result data. Default: 0
"let g:deoplete#sources#ternjs#types = 1

"" Whether to include the distance (in scopes for variables, in prototypes for
"" properties) between the completions and the origin position in the result
"" data. Default: 0
"let g:deoplete#sources#ternjs#depths = 1

"" Whether to include documentation strings (if found) in the result data.
"" Default: 0
"let g:deoplete#sources#ternjs#docs = 1

"" When on, only completions that match the current word at the given point will
"" be returned. Turn this off to get all results, so that you can filter on the
"" client side. Default: 1
"let g:deoplete#sources#ternjs#filter = 0

"" Whether to use a case-insensitive compare between the current word and
"" potential completions. Default 0
"let g:deoplete#sources#ternjs#case_insensitive = 1

"" When completing a property and no completions are found, Tern will use some
"" heuristics to try and return some properties anyway. Set this to 0 to
"" turn that off. Default: 1
"let g:deoplete#sources#ternjs#guess = 0

"" Determines whether the result set will be sorted. Default: 1
"let g:deoplete#sources#ternjs#sort = 0

"" When disabled, only the text before the given position is considered part of
"" the w_rd. When enabled (the default), the whole variable namn that the cursor
"" is on will be included. Default: 1
"let g:deoplete#sources#ternjs#expand_word_forward = 0

"" Whether to ignore the properties of Object.prototype unless they have been
"" spelled out by at least to characters. Default: 1
"let g:deoplete#sources#ternjs#omit_object_prototype = 0

"" Whether to include JavaScript keywords when completing something that is not
"" a property. Default: 0
"let g:deoplete#sources#ternjs#include_keywords = 1

"" If completions should be returned when inside a literal. Default: 1
"let g:deoplete#sources#ternjs#in_literal = 0
""Add extra filetypes
"let g:deoplete#sources#ternjs#filetypes = [
      "\ 'jsx',
      "\ 'javascript.jsx',
      "\ 'vue',
      "\ '...'
      "\ ]
"let g:deoplete#sources#clang#libclang_path='/usr/local/Cellar/llvm/5.0.0/lib/libclang.dylib'
"let g:deoplete#sources#clang#clang_header='/usr/local/Cellar/cmake/' " path/to/lib/clang
" DEOPLETE-GO
"let g:deoplete#sources#go#gocode_binary=$GOPATH.'/bin/gocode'

"augroup deoplete_aus
"autocmd!
"au FileType let g:deoplete#enable_at_startup = 1
"augroup END
"endif
" }}}
" Tern variables -------------------- {{{
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
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
let g:UltiSnipsExpandTrigger = '<tab>'
"let g:UltiSnipsListSnippets = '<s-tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-b>'
let g:UltiSnipsJumpBackwardTrigger = '<c-g>'
if has('python3')
  let g:UltiSnipsUsePythonVersion = 3
elseif has('python')
  let g:UltiSnipsUsePythonVersion = 2
endif
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetsDir = '~/dotfiles/ultisnips'
let g:UltiSnipsSnippetDirectories = ['~/dotfiles/ultisnips']
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
  autocmd FileType java :iabbrev pfc public final class {<cr>}<Esc>kk$ha
  autocmd FileType java :iabbrev sout System.out.println();<esc>hi
augroup END
" }}}
" }}}
" Filetype settings -------------------- {{{
" Scala file settings -------------------- {{{
augroup scala_auto_cmds
  autocmd!
  au FileType scala :call SetTabs(8)
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
  "au FileType sh :normal gg=G
  "au FileType sh :call SetTabs(2)
  "au FileType sh :colorscheme monochrome
  au FileType sh :set fo-=t " remove line wrap if textwidth is exceeded
  "au FileType sh :silent ! [ -f tags ] || ctags -R --language-force=sh .
augroup END
" }}}
" Markdown file settings -------------------- {{{
augroup filetype_markdown
  autocmd!
  au FileType markdown :set fo-=t " remove line wrap if textwidth is exceeded
augroup END
" }}}
" HTML file settings -------------------- {{{
"augroup filetype_html
"autocmd!
"au FileType html setlocal nowrap
"au FileType html :call SetTabs(2)
"augroup END
"}}}
" Json file settings -------------------- {{{
augroup filetype_json
  autocmd!
  au FileType json nnoremap <buffer> <leader>af :%!jq '.'<CR>
augroup END
" }}}
" Groovy file settings -------------------- {{{
"augroup groovy_aus
"autocmd!
"au FileType groovy :call SetTabs(4)
"augroup END
" }}}
" Vimscript file settings ------------------------------ {{{
augroup filetype_vim
  autocmd!
  "au FileType vim :cal SetTabs(2)
  "au FileType vim setlocal foldmethod=marker
  au FileType vim nnoremap <leader>mf o" Fold description <esc>20a-<esc>a {{{<cr><cr>}}}<esc>kcc
augroup END
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
highlight TWS ctermbg=green guibg=green
" }}}
" Neomake Filetype makers -------------------- {{{
"if has('nvim')
"" Java makers -------------------- {{{
"augroup makers_java
"autocmd!
"autocmd Filetype java let g:neomake_java_enabled_makers = [ 'gradle', 'mvn' ]
"autocmd Filetype java let b:neomake_java_enabled_makers = [ 'gradle', 'mvn' ]
"augroup END
"" }}}
"" Scala makers -------------------- {{{
"augroup makers_scala
"autocmd!
"autocmd Filetype scala let g:neomake_scala_enabled_makers = [ 'sbt', 'scalac' ]
"autocmd Filetype scala let b:neomake_scala_enabled_makers = [ 'sbt', 'scalac' ]
"augroup END
"" }}}
"" Vimscript makers -------------------- {{{
"augroup makers_vimscript
"autocmd!
"autocmd Filetype vim let g:neomake_vim_enabled_makers = [ 'vint' ]
"autocmd Filetype vim let b:neomake_vim_enabled_makers = [ 'vint' ]
"augroup END
"" }}}
"call neomake#configure#automake('w')
"endif
" }}}
" Split Navigation -------------------- {{{
let g:BASH_Ctrl_j = 'off'
"nnoremap <C-J> <C-w><C-j>
"nnoremap <C-K> <C-w><C-k>
"nnoremap <C-L> <C-w><C-l>
"nnoremap <C-H> <C-w><C-h>
" Tab navigation -------------------- {{{
nnoremap <M-h> gT
nnoremap <M-l> gt
"" }}}
" }}}
let s:tlist_def_groovy_settings = 'groovy;p:package;c:class;i:interface;' .  'f:function;v:variables'
" }}}
