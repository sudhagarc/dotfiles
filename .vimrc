" To avoid cscope duplicate db error messages
set nocscopeverbose
" Make Vim more useful
set nocompatible
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
	autocmd BufNewFile,BufRead *.yml,*.yaml setlocal filetype=yaml
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

  " my status line for coding files
  autocmd FileType c,cpp,cc,sh,java,javascript,php,vim,python,make,go setlocal stl=%f\ %m\ %r%=%y\ char:\ %-4B\ line:\ %-4l\ col:\ %-4c

  " file types with expand tab and tab width = 2
  autocmd FileType vim,javascript,c,cpp,cc,sh,java,php setlocal expandtab sw=4 sts=4 ts=4

  autocmd FileType vim setlocal autoindent
  autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab tabstop=4 autoindent nosmartindent cinwords=if,elif,else,for,while,try,except,finally,def,class fo=cq
  autocmd FileType make setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
  autocmd Filetype go setlocal shiftwidth=2 tw=0 expandtab softtabstop=2 nocindent autoindent tabstop=2

  autocmd FileType javascript setlocal expandtab shiftwidth=2 sts=2 autoindent smartindent
  autocmd FileType c,cpp,cc,sh setlocal cindent shiftwidth=4 textwidth=78 expandtab softtabstop=4 cino=:0(0
  " ignore opening bracket - )
  autocmd FileType java setlocal cindent shiftwidth=4 expandtab softtabstop=4 cino=:0(0
  " ignore opening bracket - )

  autocmd FileType php setlocal shiftwidth=2 tabstop=2 autoindent nocindent nosmartindent cino=:0(2 fo=tcroq comments=sr:/*,mb:*,ex:*/,b:// softtabstop=2 expandtab
  " ignore opening bracket - )

  autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 autoindent nocindent nosmartindent softtabstop=2 noexpandtab

  " For perforce change descriptions
  autocmd FileType conf setlocal smartindent textwidth=78 cinwords=

  " Extension to filetype mapping
  if has('gui_running')
    autocmd BufEnter * let &titlestring = hostname() . "/" . expand("%:p")
  endif
augroup end

" window movement
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"""
" custom leader mappings

" split but select new window
nnoremap <leader>v :bel vsplit<cr>
nnoremap <leader>s :bel split<cr>

" other
nnoremap <leader>q :q<cr>
nnoremap <leader>n :nohl<cr>

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

" FIXME ctrl+p stuff
" buffer switch using ctrlp
"let g:ctrlp_switch_buffer = 0
"let g:ctrlp_working_path_mode = 0

"nnoremap <leader>b :CtrlPBuffer<cr>
"nnoremap <leader>m :CtrlPMRUFiles<cr>

function! Buf_del_and_next()
  let l:curbufnr = bufnr('%')
  bprev
  execute "bdelete " . l:curbufnr
endfunction

nnoremap <leader>d :call Buf_del_and_next()<cr>

execute pathogen#infect()

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
endif

""" Formatting - clang.format
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
