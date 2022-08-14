scriptencoding uft8
syntax on
filetype plugin indent on
set runtimepath^=~/.vim
set runtimepath^=~/repos/coc.nvim
" Basic settings  {{{
let mapleader = ','
let localleader = "\\"
set textwidth=80
set path+=**
set wildignore=*.class,**/target/**,**/.idea/**,**/node_modules/**,**/bower_components/**
set wildmenu
set tags+=.git/tags
set cursorline
" Tabs -------------------- {{{
set tabstop=2 
set softtabstop=2 
set shiftwidth=2 
set expandtab
" }}}
set number
set switchbuf=usetab,useopen
" make backspace work like most other apps
set backspace=2 
set scrolloff=3
set hlsearch " highlight search words
set incsearch " search as you type
set cindent " indents more if inside brackets
set relativenumber
set list
set listchars=tab:▸·,trail:·,eol:↵
set splitbelow
set splitright
set tagstack
" }}}
" Commands  {{{
command! MakeTags !ctags 
      \ --tag-relative=yes
      \ --sort=yes -R 
      \ -f .git/tags 
      \ --exclude=bin 
      \ --exclude=xdg 
      \ --exclude=build 
      \ --exclude=plugins 
      \ --exclude=plugged 
      \ --exclude=.git 
      \ --exclude=bower_components 
      \ --exclude=node_modules 
      \ --exclude=dist 
      \ --exclude=build .
" }}}
" Plugins  {{{
call plug#begin(stdpath('data') . '/plugged')
" color schemes {{{
Plug 'benwr/tuftish'
Plug 'Leon-Plickat/paige'
Plug 'itchyny/lightline.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'sainnhe/forest-night'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'ghifarit53/tokyonight-vim'
Plug 'srcery-colors/srcery-vim'
Plug 'hzchirs/vim-material'
Plug 'ajmwagar/vim-deus'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/gruvbox-material'
Plug 'franbach/miramare'
" }}}
" Syntax for configs {{{
Plug 'GEverding/vim-hocon'
Plug 'cespare/vim-toml'
Plug 'neoclide/jsonc.vim'
" }}}
" Langs {{{
Plug 'elixir-editors/vim-elixir'
Plug 'ElmCast/elm-vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" Javascript  {{{
"Plug 'yuezk/vim-js', { 'for': 'javascript' }
"Plug 'MaxMEllon/vim-jsx-pretty', { 'for': 'javascript' }
"Plug 'othree/yajs.vim', { 'for': 'javascript' }
"Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
"Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" }}}
" Markdown {{{
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'shime/vim-livedown', { 'for': 'markdown' }
" }}}
" Go {{{
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'AndrewRadev/splitjoin.vim', { 'for': 'go' }
" }}}
Plug 'martinda/Jenkinsfile-vim-syntax', { 'for': 'Jenkinsfile' }
Plug 'vim-latex/vim-latex'
Plug 'udalov/kotlin-vim'
Plug 'tfnico/vim-gradle'
Plug 'vimwiki/vimwiki'
"Plug 'mhartington/nvim-typescript', { 'for': 'typescript' }
"Plug 'tpope/vim-cucumber'
" }}}
" Git {{{
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
" fugitive extension for Github
Plug 'tpope/vim-rhubarb'
" }}}
" Search {{{
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'ctrlpvim/ctrlp.vim'
" }}}
"Plug 'thinca/vim-quickrun'
Plug 'editorconfig/editorconfig-vim'
Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic', { 'for': 'terraform' }
Plug 'juliosueiras/vim-terraform-completion'
Plug 'junegunn/goyo.vim'
Plug 'jlanzarotta/bufexplorer'
" Text aligment based on a given character
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
" Auto complete for brackets and quotes
Plug 'Raimondi/delimitMate'
"Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-subversive'
Plug 'alvan/vim-closetag', { 'for': 'html' }
"Plug 'christoomey/vim-titlecase'
Plug 'majutsushi/tagbar'
" Git signs for modified files
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'xolox/vim-misc'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
"Plug 'yegappan/mru'
"Plug 'bling/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'SirVer/ultisnips'
call plug#end()
" }}}
" Mappings  {{{
let g:BASH_Ctrl_j = 'off'
" Insert mode  {{{
inoremap <F5> <C-R>=strftime("%c")<CR>
" Commodities, maybe this can be improved with operator pending movements
" but then it won't work in IDEA as only the vim default operator pending
" movements are supported
inoremap jF) <Esc>f)i
inoremap jF} <Esc>f}i
inoremap jF, <Esc>f,i
inoremap jB( <Esc>F(i
inoremap jB, <Esc>F,i
inoremap jB{ <Esc>F{i
" Uses markers, should change
inoremap jZ) <Esc>mpf)dl`pa
inoremap jZ, <Esc>mpf,dl`pa
inoremap jQ  <Esc>f{%O
inoremap jR2 <Esc>20a
inoremap jR5 <Esc>50a
inoremap jK <Esc>:m-2<cr>i
inoremap jJ <Esc>:m+1<cr>i
inoremap jU <Esc>ui
inoremap jn <Esc>o
inoremap jI <Esc>^i
inoremap jA <Esc>g_a
inoremap jW <Esc>wa
inoremap jE <Esc>ea
inoremap jO <Esc>O
inoremap <C-s> <Esc>:w<cr>
inoremap <C-u> <Esc>xi
inoremap <C-l> <Esc>lxi
inoremap <m-j> <down>
inoremap <m-k> <up>
inoremap <m-h> <left>
inoremap <m-l> <right>
inoremap jk <esc>l
" }}}
" Normal mode  {{{
nnoremap T :tabclose<cr>
nnoremap <silent> <localleader>cc :cclose<cr> :lclose<cr>
"nnoremap <leader>zf f{v%zf<esc>
"nnoremap <leader>zF F{v%zf<esc>
"nnoremap <leader>g :silent :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
nnoremap / /\v\c
nnoremap ? ?\v\c
" Clear matches and highlights
nnoremap <Esc> :noh<CR>:mat none<cr>
" Match word under cursor
highlight TWS ctermbg=green guibg=green
nnoremap cm :match TWS /\<<C-r><C-w>\>/<cr>
" Replace word under cursor
nnoremap <leader>sr :match TWS /\<<C-r><C-w>\>/<cr>:%s/\<<C-r><C-w>\>/
nnoremap <leader>qe a<cr><esc>
nnoremap <leader>qw i<cr><esc>
nnoremap <leader>ev :tabnew ~/dotfiles/init.vim<CR>
nnoremap <leader>sv :so ~/dotfiles/init.vim<CR>
" edit a new buffer in the current pane even with changes
nnoremap <leader>enn :ene<cr>
" edit a new buffer in the current pane if no changes
nnoremap <leader>enf :ene!<cr>
" Easier pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-s> :w<cr>
nnoremap <m-k> :m-2<CR>
nnoremap <m-j> :m+1<CR>
nnoremap <m-h> gT
nnoremap <m-l> gt
nnoremap <s-d> :co.<cr>
nnoremap <s-c> :bd<CR>
nnoremap <s-q> :bd!<CR>
" Vimdiff
nnoremap <localleader>vdl :diffget LOCAL<cr>
nnoremap <localleader>vdb :diffget BASE<cr>
nnoremap <localleader>vdr :diffget REMOTE<cr>
" Open a vertical pane to the right
nnoremap <C-v><localleader> :vsplit ene<cr>
" Open an horizontal pane to the left
nnoremap <C-v>- :split ene<cr>
" }}}
" All modes  {{{
noremap <localleader>nf :set nofoldenable!<CR>
noremap <C-n> :cn<CR>
noremap <C-m> :cp<CR>
" }}}
" Vimwiki  {{{
augroup vimwiki_mappings
  autocmd!
  au FileType vimwiki map <localleader>vwt <Plug>VimwikiToggleListItem
  au FileType vimwiki map <localleader>vwhh :Vimwiki2HTML<CR>
  au FileType vimwiki map <localleader>vwhb :Vimwiki2HTMLBrowse<CR>
augroup END
" }}}
" Quick fix  {{{
augroup filetype_mappings_quickfix
  autocmd!
  autocmd FileType qf noremap <localleader>cc :cclose<cr> :lclose<cr>
augroup END
" }}}
" }}}
" Configs  {{{
" ALE  {{{
let g:ale_completion_enabled = 0
let g:ale_update_tagstack = 0
let g:ale_hover_cursor = 0

let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'javascript': ['eslint'],
      \   'vue': ['eslint'],
      \   'vim': ['vint'],
      \   'sh': ['shellcheck'],
      \   'json': ['jq'],
      \   'md': ['markdownlint-cli2'],
      \   'typescript': ['eslint']
      \}

let g:ale_linters_ignore = {
      \ 'typescript': ['tslint']
      \}

let g:airline#extensions#ale#enabled = 1

let g:ale_emit_conflict_warnings = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[ALE: %linter%][%severity%] - %s '

let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \   'javascript': ['eslint'],
      \   'json': ['fixjson'],
      \   'typescript': ['eslint']
      \}

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_sign_highlight_linenrs = 1
let g:ale_echo_cursor = 0
let g:ale_virtualtext_cursor = 1
" Opens the detail in a new buffer at bottom
let g:ale_cursor_detail = 0
let g:ale_close_preview_on_insert = 1
let g:ale_set_balloons = 1
" }}}
" MRU  {{{
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'
let MRU_Window_Height = 15
let MRU_Use_Current_Window = 0
let MRU_Auto_Close = 1
" }}}
" Shebanger  {{{
"let g:shebanger_shebang_line = '#!/usr/bin/env zsh'
" }}}
" Rust  {{{
let g:rustfmt_autosave = 1
" }}}
" Fzf  {{{
let g:fzf_layout = { 'window': 'enew' }
nnoremap <leader>F :FzfFiles!<cr>
nnoremap <leader>G :FzfGFiles!<cr>
nnoremap <leader>S :FzfSnippets!<cr>
nnoremap <leader>B :FzfBuffers!<cr>
nnoremap <leader><c-f> :FzfBLines!<cr>
nnoremap <leader>L :FzfLines!<cr>
nnoremap <leader>A :FzfAg!<cr>
nnoremap <leader>T :FzfBTags!<cr>
nnoremap <leader>M :FzfMarks!<cr>
nnoremap <leader>C :FzfBCommits!<cr>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
let g:fzf_command_prefix = 'Fzf'
" Insert mode completion
imap <c-j><c-p> <plug>(fzf-complete-path)
imap <c-j><c-f> <plug>(fzf-complete-file-ag)
" }}}
" vim-go  {{{
augroup vim_go_auto_commands
  autocmd!
  au FileType go nnoremap <localleader>gob :GoBuild<CR>
  au FileType go nnoremap <localleader>gots :GoTest<CR>
  au FileType go nnoremap <localleader>gotf :GoTestFunc<CR>
  au FileType go nnoremap <localleader>goi :GoImports<CR>
  au FileType go nnoremap <localleader>gode :GoDef<CR>
  au FileType go nnoremap <localleader>godo :GoDoc<CR>
  au FileType go nnoremap <localleader>goc :GoCoverageToggle<cr>
  au FileType go nnoremap <localleader>gov :GoVet<cr>
  au FileType go nnoremap <localleader>gom :GoMetaLinter<cr>
  au FileType go nnoremap <localleader>goa :GoAlternate<cr>
  au FileType go nnoremap <localleader>gop :GoChannelPeers<CR>
augroup END
let g:go_fold_enable = ['varconst','block','import','comment', ]
let g:go_rename_command = 'gopls'
let g:go_def_mode = 'gopls'
let g:go_fillstruct_mode = 'fillstruct'
let g:go_referrers_mode = 'gopls'
let g:go_implements_mode = 'gopls'
"let g:go_info_mode='gopls'
let g:go_fmt_command='goimports'
let g:go_term_reuse = 1
let g:go_gopls_enabled = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 0
let g:go_highlight_types = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_code_completion_enabled = 1
let g:go_test_show_name = 1
let g:go_auto_sameids = 0
let g:go_auto_type_info = 1
let g:go_doc_popup_window = 1
let g:go_snippet_engine = 'ultisnips'
let g:go_statusline_duration = 20000
let g:go_metalinter_autosave = 0
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_template_autocreate = 1
let g:go_fmt_options = {
      \ 'gofmt': '-s',
      \ }
" }}}
" vim-yoink  {{{
let g:yoinkIncludeDeleteOperations = 1
"nmap <c-n> <plug>(YoinkPostPasteSwapForward)
"nmap <c-p> <plug>(YoinkPostPasteSwapBack)
"nmap p <plug>(YoinkPaste_p)
"nmap P <plug>(YoinkPaste_P)
"nmap [y <plug>(YoinkRotateBack)
"nmap ]y <plug>(YoinkRotateForward)
" }}}
" vim-cutlass  {{{
nnoremap x d
xnoremap x d
nnoremap xx dd
" }}}
" vim-subversive  {{{
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)
" }}}
" vim-javascript  {{{
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
" }}}
" vim-latex  {{{
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
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
" Signify  {{{
let g:signify_vcs_list = ['git']
let g:signify_line_highlight = 0
let g:signify_fold_context = [2, 5]
let g:signify_sign_show_text = 1
nnoremap <localleader>shd :SignifyHunkDiff<cr>
nnoremap <localleader>sd :SignifyDiff<cr>
nnoremap <localleader>sD :SignifyDiff!<cr>
nnoremap <localleader>shu :SignifyHunkUndo<cr>
nnoremap <localleader>shU :SignifyHunkUndo!<cr>
nnoremap <localleader>sf :SignifyFold<cr>
nnoremap <localleader>sF :SignifyFold!<cr>
" }}}
" Livedown  {{{
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 0
" should the browser window pop-up upon previewing
let g:livedown_open = 1
" the port on which Livedown server will run
let g:livedown_port = 1337
" the browser to use
let g:livedown_browser = 'firefox'
" }}}
" Tagbar  {{{
nmap <localleader><localleader>t :TagbarToggle<CR>
" }}}
" NERDTree  {{{
nnoremap <localleader><localleader>n :NERDTreeToggle<CR>
" }}}
" Netrw  {{{
let g:netrw_banner = 0
let g:netrw_altv = 1 " open splits to the right
let g:netrw_liststyle = 3 " tree view
" }}}
" Scalafmt  {{{
let g:formatdef_scalafmt = "'scalafmt --stdin'"
let g:formatters_scala = ['scalafmt']
" }}}
" Easymotion  {{{
"nmap <localleader>emw <Plug>(easymotion-overwin-w)
"map <localleader>emj <Plug>(easymotion-j)
"map <localleader>emk <Plug>(easymotion-k)
" }}}
" Titlecase  {{{
nmap <localleader>tcw <Plug>Titlecase
nmap <localleader>tcl <Plug>TitlecaseLine
let g:titlecase_map_keys = 0
" }}}
" Airline variables  {{{
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_symbols = {}
" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.maxlinenr = '㏑'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
"let g:airline_symbols.notexists = 'Ɇ'
"let g:airline_symbols.whitespace = 'Ξ'
"" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.maxlinenr = ''
"let g:airline_powerline_fonts = 1
"let g:airline_theme='wombat'
let g:airline_theme = 'miramare'
" }}}
" UltiSnips variables  {{{
let g:UltiSnipsExpandTrigger = '<c-b>'
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
" Vimwiki variables  {{{
let g:vimwiki_list = [{ 'auto_toc': 1, 'list_margin': 2}]
let g:vimwiki_auto_checkbox=1
let g:vimwiki_list_ignore_newline=0
" }}}
" Git slides settings  {{{
let g:gitslides_use_custom_mappings = 0
" }}}
" COC Settings  {{{
"if hidden is not set, TextEdit might fail.
function! g:LoadCOCVim()
  set hidden
  " Some servers have issues with backup files, see #649
  set nobackup
  set nowritebackup
  " Better display for messages
  set cmdheight=2
  " You will have bad experience for diagnostic messages when it's default 4000.
  set updatetime=300
  " don't give |ins-completion-menu| messages.
  set shortmess+=c
  " always show signcolumns
  set signcolumn=yes
  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  " Or use `complete_info` if your vim support it, like:
  " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  "nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction
  " Highlight symbol under cursor on CursorHold
  augroup coc_cursorhold
    autocmd!
    autocmd CursorHold * silent call CocActionAsync('highlight')
  augroup end
  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)
  " Remap for format selected region
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)
  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end
  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)
  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)
  " Create mappings for function text object, requires document symbols feature of languageserver.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)
  " Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)
  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')
  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)
  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
  " Add status line support, for integration with other plugin, checkout `:h coc-status`
  "set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Using CocList
  " Show all diagnostics
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
  let g:go_def_mapping_enabled = 0
  let g:coc_node_path = expand('~/dotfiles/bin/nodejs/current/bin/node')
  " use <c-space>for trigger completion
  inoremap <silent><expr> <c-space> coc#refresh()
  "" Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endfunction

"}}}
" CtrlP Settings {{{
let g:ctrlp_show_hidden = 1
" }}}
" }}}
" Abbreviations  {{{
augroup general_abbreviations
  autocmd!
  :iabbrev adn and
  :iabbrev treu true
  :iabbrev flase false
augroup END
" }}}
" Color Settings  {{{
set t_Co=256
if (has('termguicolors'))
  set termguicolors
endif

syntax enable

set completeopt=menuone,noinsert,noselect,preview,longest
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'medium'
let g:gruvbox_hls_cursor = 'aqua'
let g:gruvbox_improved_strings = 0
" }}}
" Go LSP {{{
"go.impl.cursor              Generate   interface   stubs
"go.install.gomodifytags     Install    /           update    gomodifytags
"go.install.goplay           Install    /           update    goplay
"go.install.gopls            Install    /           update    gopls
"go.install.gotests          Install    /           update    gotests
"go.install.impl             Install    /           update    impl
"go.install.tools            Install    /           update    all            tools
"go.playground               Run        on          go        playground
"go.tags.add                 Add        tags        to        struct         fields
"go.tags.add.line            Add        tags        to        struct         field      in          current   line
"go.tags.add.prompt          Add        tags        to        struct         fields     (prompt)
"go.tags.clear               Remove     all         tags      from           struct     fields
"go.tags.clear.line          Remove     all         tags      from           struct     fields      in        current   line
"go.tags.remove              Remove     tags        from      struct         fields
"go.tags.remove.line         Remove     tags        from      struct         field      in          current   line
"go.tags.remove.prompt       Remove     tags        from      struct         fields     (prompt)
"go.test.generate.exported   Generate   unit        tests     for            exported   functions   in        file
"go.test.generate.file       Generate   unit        tests     for            file
"go.test.generate.function   Generate   unit        tests     for            current    function
"go.test.toggle              Toggle     test        file
"go.version                  Print      extension   version
"
" }}}
" Must be last
:call LoadCOCVim()
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'coc' ] ]
      \ },
      \ 'component': {
      \   'coc': 'coc-vim: %{coc#status()}%{get(b:,"coc_current_function","")}'
      \ },
      \ 'mode_map': {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ },
      \ }
