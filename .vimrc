" Make Vim more useful
set nocompatible

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_langs = "go"
let g:vim_bootstrap_editor = "vim"				" nvim or vim

" Required:
call plug#begin(expand('~/.vim/plugged'))

" Add bundles
" Main Go plugin for vim
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
" For split & join (gS & gJ)
Plug 'AndrewRadev/splitjoin.vim'
" Colorscheme - requires/for darkbackground
" Plug 'fatih/molokai'
Plug 'tomasr/molokai'
" Control-P - file browser
Plug 'ctrlpvim/ctrlp.vim'
" nerd tree
" Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
" Comment / uncomment code blocks
Plug 'tpope/vim-commentary'
" Git helper (see, shortcuts below)
Plug 'tpope/vim-fugitive'
" Airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Track git changes
Plug 'airblade/vim-gitgutter'
" Grep plugins
Plug 'vim-scripts/grep.vim'
" Colorscheme approximation
" Plug 'vim-scripts/CSApprox'
" Highlight whitespaces @ eol
Plug 'bronson/vim-trailing-whitespace'
" Delimit helper
Plug 'Raimondi/delimitMate'
" tagbar
" Plug 'majutsushi/tagbar'
" language syntax
Plug 'scrooloose/syntastic'
" show indent lines
Plug 'Yggdroot/indentLine'
" Plug 'avelino/vim-bootstrap-updater'
" Language pack for vim
Plug 'sheerun/vim-polyglot'
" fuzzy command completion
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
" Interactive command line execution
Plug 'Shougo/vimproc.vim', {'do': g:make}

" Vim-Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

if v:version >= 703
  Plug 'Shougo/vimshell.vim'
endif

if v:version >= 704
  " Go snippets
  " TODO: Fix this on macOs; comment on macOs for now
  Plug 'SirVer/ultisnips'
endif

" Plug 'honza/vim-snippets'
" Plug 'Shougo/neocomplete'
" tab completion
Plug 'ervandew/supertab'
call plug#end()

let g:rehash256 = 1
let g:molokai_original = 1

" To avoid cscope duplicate db error messages
set nocscopeverbose
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Copy previous indent when auto indenting
set copyindent
" indent rounded to shiftwidth
set shiftround

" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
set fileencoding=utf-8
set fileencodings=utf-8
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Auto read the file if it's changed outside vim
set autoread
" Buffer hiding - Need to understand more
set hidden

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax enable
" Highlight current line
" set cursorline
" Make tabs as wide as two spaces
set tabstop=2
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set listchars=
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
set smartcase

" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd

set mousehide "hide mouse while typing
set wildmode=list:full

" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Disable filetype detection
filetype off
" Enable filetype indentation & plugin
filetype indent plugin on

" For new MacBook Pro, where 'esc' is on touchbar
imap `` <Esc>
imap jj <Esc>
imap kk <Esc>
imap <C-c> <Esc>

" FIXME: To ignore line wrap during line movement
" nmap j gj
" vmap j gj
" nmap k gk
" vmap k gk

" Enable silent transfer for remote editing
let g:netrw_silent=1

augroup sudhagar
    au!
    autocmd BufNewFile,BufRead *.make,*.mk setlocal filetype=make
    autocmd BufNewFile,BufRead Makefile setlocal filetype=make
    autocmd BufNewFile,BufRead *.csv setlocal filetype=csv
	autocmd BufNewFile,BufRead SCons* setlocal filetype=python
	autocmd BufNewFile,BufRead *.sc setlocal filetype=python
	autocmd BufNewFile,BufRead *.phpt setlocal filetype=php
	autocmd BufNewFile,BufRead *.php setlocal filetype=php cc=80,81,82
	autocmd BufNewFile,BufRead *.txt setlocal filetype=text
	autocmd BufNewFile,BufRead *.go setlocal filetype=go
	autocmd BufNewFile,BufRead README setlocal filetype=text
	autocmd BufNewFile,BufRead *.tcc setlocal filetype=cpp
	autocmd BufNewFile,BufRead *.thrift setlocal filetype=thrift
	autocmd BufNewFile,BufRead *.yml,*.yaml,*.tmpl setlocal filetype=yaml
	autocmd BufNewFile,BufRead *.robot setlocal filetype=robot
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *js setlocal filetype=javascript
	autocmd BufNewFile,BufRead *js,*.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

  " my status line for coding files
  autocmd FileType c,cpp,cc,sh,java,javascript,php,vim,python,make,go setlocal stl=%f\ %m\ %r%=%y\ char:\ %-4B\ line:\ %-4l\ col:\ %-4c

  " file types with expand tab and tab width = 2
  autocmd FileType vim,javascript,c,cpp,cc,sh,java,php setlocal expandtab sw=4 sts=4 ts=4

  autocmd FileType vim setlocal autoindent
  autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab tabstop=4 autoindent nosmartindent cinwords=if,elif,else,for,while,try,except,finally,def,class fo=cq
  autocmd FileType make setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
  autocmd Filetype go setlocal shiftwidth=4 tw=0 noexpandtab softtabstop=4 nocindent autoindent tabstop=4

  autocmd FileType javascript setlocal expandtab shiftwidth=2 sts=2 autoindent smartindent
  autocmd FileType c,cpp,cc,sh setlocal cindent shiftwidth=4 textwidth=78 expandtab softtabstop=4 cino=:0(0
  " ignore opening bracket - )
  autocmd FileType java setlocal cindent shiftwidth=4 expandtab softtabstop=4 cino=:0(0
  " ignore opening bracket - )

  autocmd FileType php setlocal shiftwidth=2 tabstop=2 autoindent nocindent nosmartindent cino=:0(2 fo=tcroq comments=sr:/*,mb:*,ex:*/,b:// softtabstop=2 expandtab
  " ignore opening bracket - )

  autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 autoindent nocindent nosmartindent softtabstop=2 expandtab
  autocmd FileType robot setlocal expandtab sw=4 sts=4 ts=4 autoindent nosmartindent
  autocmd FileType markdown setlocal expandtab sw=4 sts=4 ts=4 autoindent nosmartindent

  " For perforce change descriptions
  autocmd FileType conf setlocal smartindent textwidth=78 cinwords=

  " Extension to filetype mapping
  if has('gui_running')
    autocmd BufEnter * let &titlestring = hostname() . "/" . expand("%:p")
  endif
augroup end

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"""
" custom leader mappings

" split but select new window
nnoremap <leader>v :bel vsplit<cr>
nnoremap <leader>h :bel split<cr>

" re-read vimrc
nnoremap <leader>S :source ~/.vimrc<cr>

" FIXME: tag lookup
" nnoremap <leader>t :tj<space>/

" use ; as : in normal mode
nnoremap ; :
nmap Q gqap

""" ctags
if filereadable(glob("~/code/tags"))
  set tags=~/code/tags
else
  " look at parent directories up to / for tags file
  set tags=tags;/
endif

""" Command-T
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/tmp/*,*.tgz,*.tar.gz,*.zip
set wildignore+=*.o,*.a,*.so,*.swp

""" perforc
"nmap <C-P>e :!p4 edit %<cr>:set modifiable<cr>
"nmap <C-P>r :!p4 revert %<cr>:set nomodifiable<cr>
"nmap <C-P>a :!p4 add %<cr>

" let g:p4OptimizeActiveStatus = 0
"

" turn off re-indenting of # comments in smartindent
" inoremap # X^H#

" teach vim about screen's escape sequences for setting the title
if &term == "screen" || &term == "screen-256color"
  set t_ts=^[k
  set t_fs=^[\
else
  if has("mouse")
    set mouse=a   " enable mouse support but only if not in screen
  endif
endif

" setup 256 color mode for terminals that support it
if &term == "screen-256color" || &term == "xterm-256color"
  set t_Co=256
endif

" kill any trailing whitespace on save
function! Setup_trailing_whitespace_hook()
  augroup kill_trailing_whitespace_inner
    au! * <buffer>
    autocmd BufWritePre <buffer>
      \ call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
  augroup end
endfunction

augroup kill_trailing_whitespace
  au!
  autocmd FileType c,css,cabal,cpp,haskell,javascript,php,python,readme,text
    \ call Setup_trailing_whitespace_hook()
augroup end

" set up git grep as external grep
set grepprg=git\ grep\ -n\ $*

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

"*****************************************************************************
" Abbreviations
"*****************************************************************************
" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" vimshell.vim
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '

" terminal emulation
if g:vim_bootstrap_editor == 'nvim'
  nnoremap <silent> <leader>sh :terminal<CR>
else
  nnoremap <silent> <leader>sh :VimShellCreate<CR>
endif

"*****************************************************************************
" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

""" Mappings

" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

" Close buffer
noremap <leader>c :bd<CR>

" Clean search (highlight)
nnoremap <silent> <leader><space> :nohl<cr>

" Switching windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

" go
" vim-go
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:syntastic_go_checkers = ['golint', 'govet']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1

augroup completion_preview_close
  autocmd!
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

augroup go

  au!
  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AH call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

  au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>db <Plug>(go-doc-browser)

  au FileType go nmap <leader>r  <Plug>(go-run)
  au FileType go nmap <leader>t  <Plug>(go-test)
  au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
  au FileType go nmap <C-g> :GoDecls<cr>
  au FileType go nmap <leader>dr :GoDeclsDir<cr>
  au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
  au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
  au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>

augroup END

"*****************************************************************************
" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" FIXME ctrl+p stuff
" buffer switch using ctrlp
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>m :CtrlPMRUFiles<cr>

function! Buf_del_and_next()
  let l:curbufnr = bufnr('%')
  bprev
  execute "bdelete " . l:curbufnr
endfunction

nnoremap <leader>d :call Buf_del_and_next()<cr>

execute pathogen#infect()


" syntastic cpp / qt header files
let g:syntastic_cpp_include_dirs = ["/Users/sudhagar/Qt5.9/5.9.1/Src/qtbase/include"]
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": ["cpp"] }

" syntastic jslint config
" let g:syntastic_javascript_jslint_args = '--white --nomen --regexp --plusplus --bitwise --newcap --sloppy --vars --predef=Parse --predef=exports'
let g:syntastic_check_on_open = 1
" only use jshint for js
let g:syntastic_javascript_checkers = ['jshint']

if has("gui_macvim")
  nnoremap <C-left> :BufSurfBack<CR>
  nnoremap <C-right> :BufSurfForward<CR>
else
  nnoremap <leader>[ :BufSurfBack<CR>
  nnoremap <leader>] :BufSurfForward<CR>
endif

" display stuff last, which overrides anything set above
if has("gui_running")
  "set lines=70
  "set columns=200
  set guioptions-=T
  if has("gui_macvim")
    " set guifont=Source\ Code\ Pro\ Light:h12
    set linespace=1
    " tweak on darkblue to italicize comments
    hi Comment term=bold ctermfg=4 guifg=#80a0ff gui=italic
    hi LineNr guifg=#777777
    set cursorline
    hi CursorLine guibg=#202070
  endif

  if has("gui_win32")
    set guifont=Consolas:h10:cANSI
  endif
  if has("gui_gtk2")
    set guifont=Fixed7x13\ 10
    set visualbell
    set linespace=1
    " kill scrollbars
    set guioptions-=m
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=b
  endif
else
  " no gui

  hi type      cterm=bold
  hi Statement cterm=bold
  hi Define    cterm=bold
  hi Special   ctermfg=darkred
  hi ColorColumn ctermbg=lightgrey

  " jump 10 lines at a time when scrolling to reduce redraw
  set sj=10
  " always show 3 lines of context around cursor
  set so=3

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1
endif

" Formatting - clang.format
map <leader>f :pyf /usr/local/share/clang/clang-format.py<CR>
imap <leader>f <ESC>:pyf /usr/local/share/clang/clang-format.py<CR>i

" set default colorscheme
colorscheme summerfruit256
" Set background to match the terminal
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

" Map a new key for toggling comments and revert C to default behavior
"noremap <leader>C :call ToggleComment()<CR>
"nunmap C

" this is used when vim calls make and vim-go also uses
" it to when doing go-build, go-test, ...
set autowrite

" Mappings for navigating the quickfix list
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" my custom mappings
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" my custom vim-go mappings
" https://github.com/fatih/vim-go-tutorial
au FileType go nmap <leader>c <Plug>(go-coverage)

" vim-go settings
"let g:go_snippet_case_type = "camelcase"
let g:go_snippet_case_type = "snakecase"

"" neocomplete settings
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

"HTML Tidy for Syntastic
let g:syntastic_html_tidy_ignore_errors = [ '<link> proprietary attribute "integrity"', '<link> proprietary attribute "crossorigin"' ]