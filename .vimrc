" Benz Vimz
" Maintainer:   Ben Hayden
" Version:      0.1

" Set to plain 'ol Bash
set shell=/bin/bash

" Set up vim-plug if missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup plug_install
    au!
    au! VimEnter * PlugInstall
  augroup END
endif

" ===========
" Plugin List
" ===========

call plug#begin('~/.vim/plugged')

" Base16 Colorscheme
Plug 'beardedprojamz/base16-vim'
" Tim Pope Time
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
" Bumpin' Statusline
Plug 'bling/vim-airline'
" Syntax Checking
Plug 'scrooloose/syntastic'
" Better Python Indenting
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
" Less support
Plug 'groenewege/vim-less', { 'for': 'less' }
" Unite.vim for uniting all user interfaces
Plug 'Shougo/vimproc.vim', { 'do': function('fxns#MakeVimProc') }
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'     " Most recently used
Plug 'Shougo/unite-outline'  " Function/Class Outline
Plug 'tsukkee/unite-tag'     " Search ctags
" Auto completion
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets'
" Notice Git File changes
Plug 'airblade/vim-gitgutter'
" Autopairing
Plug 'jiangmiao/auto-pairs'
" Match HTML Tags
Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'jinja', 'mako'] }
" Auto close HTML Tags
Plug 'alvan/vim-closetag', { 'for': 'html' }
" Salt highlighting
Plug 'saltstack/salt-vim', { 'for': 'sls' }
" Puppet highlighting
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
" Mako highlighting
Plug 'sophacles/vim-bundle-mako', { 'for': 'mako' }
" Jinja highlighting
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }
" Golang tools
Plug 'fatih/vim-go', { 'for': 'go' }
" JS & JSX tools
Plug 'pangloss/vim-javascript', { 'for': ['js', 'jsx'] }
Plug 'mxw/vim-jsx', { 'for': 'jsx' }

call plug#end()

" =============
" Basic Options
" =============

set wildmode=longest,list,full
set hidden
set nostartofline
set mouse=a
set nowrap
set ignorecase
set infercase
set smartcase
set autochdir
set tags=./tags;
set undolevels=1000
" Persistent undo
if !isdirectory($HOME.'/.vim/undo')
    call mkdir($HOME.'/.vim/undo', 'p')
endif
set undofile
set undodir=~/.vim/undo
" Keep temp files stored in one place
if !isdirectory($HOME.'/.vim/tmp')
    call mkdir($HOME.'/.vim/tmp', 'p')
endif
set directory=~/.vim/tmp
" Automatically insert comment leader on return,
" and let gq format comments
set formatoptions=rq

" ==========
" UI Options
" ==========

set hlsearch
set background=dark
set number
set cursorline
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-atelierforest

" =====================================
" Mappings, Commands, and Auto Commands
" =====================================

let mapleader=','
" Edit .vimrc
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
" Simple Keybindings
nnoremap <Leader>c :close<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>q :quit!<CR>
nnoremap <Leader>d :bdelete!<CR>
nnoremap <Leader>. :only<CR>
" Write as sudo
command! W w !sudo tee % > /dev/null
" Shortcut for posting to slack channels
command! -range Slack <line1>,<line2> call fxns#Slack()
vnoremap <Leader>sl <Esc>:'<,'>:Slack<CR>
" Count current word
command! Count call fxns#Count()
nnoremap <Leader>n :Count<CR>
" System clipboard mappings
vnoremap <Leader>y "*y
nnoremap <Leader>a :%y+<CR>
vnoremap <Leader>x "*x
vnoremap <Leader>pp "*p
vnoremap <Leader>pP "*P
nnoremap <Leader>pp "*p
nnoremap <Leader>pP "*P
" Search visually selected text
vnoremap // y/<C-R>"<CR>"
" 'Parameters' Operator mapping
" Usage: dp - Delete between ()
onoremap p i(
" Indent from normal mode
nnoremap <C-j> i<CR><Esc>

augroup dotvimrc
  au!
  " Trim Whitespace before write
  au! BufWritePre * %s/\s\+$//e
  " Reopen at last location
  au! BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != 'gitcommit'
        \| exe "normal! g'\"" | endif
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=tern#Complete
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

" ===================
" Airline Settings
" ===================

let g:airline_powerline_fonts = 1

" ===================
" Syntastic Settings
" ===================

let g:syntastic_check_on_open = 1 " Run Syntastic when opening files
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['python', 'pyflakes'] " Be more strict in python syntax
let g:syntastic_vim_checkers = ['vint']
let g:syntastic_go_checkers = ['']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ignore_files = ['\m.xonshrc$', '\m\c\.xsh$']
nnoremap <Leader>el :lopen<CR>

" =================
" Vim-plug Mappings
" =================

nnoremap <Leader>pi :PlugInstall<CR>
nnoremap <Leader>pu :PlugUpdate<CR>
nnoremap <Leader>pc :PlugClean<CR>
nnoremap <Leader>ps :PlugStatus<CR>

" =========================
" Unite Settings & Mappings
" =========================

let g:unite_source_history_yank_enable = 1
let g:unite_data_directory = expand('~/.vim/cache/unite')
let g:neomru#file_mru_path = expand('~/.vim/cache/neomru/file')
let g:neomru#directory_mru_path = expand('~/.vim/cache/neomru/directory')
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-i --line-numbers --nocolor --nogroup --hidden'
let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup',
\  '--hidden', '-g', '']
let g:unite_source_grep_recursive_opt = ''
call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'winheight': 10
\ })
nnoremap <Leader>t :Unite -buffer-name=files   -start-insert file_rec/async:!<CR>
nnoremap <Leader>r :Unite -buffer-name=tags    -start-insert tag<CR>
nnoremap <Leader>/ :Unite -buffer-name=grep    -start-insert -no-quit grep<CR>
nnoremap <Leader>? :UniteWithCursorWord -buffer-name=grep    -no-quit grep<CR>
nnoremap <Leader>f :Unite -buffer-name=files   -start-insert file<CR>
nnoremap <Leader>F :Unite -buffer-name=files   -start-insert file/new<CR>
nnoremap <Leader>u :Unite -buffer-name=mru     -start-insert file_mru<CR>
nnoremap <Leader>o :Unite -buffer-name=outline -start-insert outline<CR>
nnoremap <Leader>L :Unite -buffer-name=buffer  -start-insert buffer<CR>
nnoremap <Leader>l :Unite -buffer-name=buffer  -quick-match  buffer<CR>
nnoremap <Leader>y :Unite -buffer-name=yank    history/yank<CR>
nnoremap <Leader>m :UniteResume<CR>

" ===============================
" Neocomplete Settings & Mappings
" ===============================

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Let Neocomplete close the preview window.
let g:neocomplete#enable_auto_close_preview = 1

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : '') . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" ===============================
" Neosnippets Settings & Mappings
" ===============================

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" ===================
" Commentary Mappings
" ===================

nmap <Leader>, <Plug>CommentaryLine
vmap <Leader>, <Plug>Commentary

" =================
" Fugitive Mappings
" =================

nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>go :Gbrowse<CR>
nnoremap <Leader>gO :Gbrowse!<CR>
vnoremap <Leader>go :Gbrowse<CR>
vnoremap <Leader>gO :Gbrowse!<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>

" ===============
" vim-go Settings
" ===============

let g:go_autodetect_gopath = 0

" vim:set ft=vim et sw=2:
