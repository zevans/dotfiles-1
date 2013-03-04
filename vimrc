" .vimrc
"
" Credits:        http://zanshin.net/2011/11/15/using-vim/
"                 https://gist.github.com/1367558#file_.vimrc
"
" Dependencies:   https://github.com/gmarik/vundle
"
"==============================================================================
" Use Vim settings rather than vi settings (must be first)
"------------------------------------------------------------------------------

set nocompatible

"==============================================================================
" Setup Vundle and plugins
" Refresh with :BundleInstall
"------------------------------------------------------------------------------

filetype on                                " Enable it first for git exit code
filetype off                               " Disable for Vundle load
set rtp+=~/.vim/bundle/vundle/             " Add Vundle subdir to run time path
call vundle#rc()                           " Enable vundle
Bundle 'altercation/vim-colors-solarized'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'Lokaltog/vim-powerline'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'puppetlabs/puppet-syntax-vim'
Bundle 'jeffkreeftmeijer/vim-numbertoggle'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-ragtag'

filetype plugin indent on                  " (Re)enable filetype and indenting

"==============================================================================
" Basic options
"------------------------------------------------------------------------------

set history=50      " Longer command history for q:
set vb              " No audible bell
let mapleader=","  " Remapped from \"
set laststatus=2    " Always show status bar for powerline
set t_Co=16        " Use in case of xterm sans 256 color
set ignorecase      " Searches are case insenstive by default
set smartcase       "     unless search contains Uppercase character
set wildmode=longest,list,full " more natural tab completion
set wildmenu
set incsearch
set vb t_vb=

"==============================================================================
" Key Mappings
"------------------------------------------------------------------------------
inoremap jj <Esc>
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>l :set list!<CR>
nmap <leader>g :Gstatus<CR>

"==============================================================================
" Appearance options
"------------------------------------------------------------------------------

syntax on
set number             " Turn this off for copy with 'set nonumber'
if exists('+colorcolumn') " Marks the 80th character column
  set colorcolumn=80
endif
set background=light
colorscheme solarized
:call togglebg#map("") " Required to call activate function
set listchars=tab:▸\ ,eol:¬
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59


"==============================================================================
" Tab and indent options
"------------------------------------------------------------------------------

set tabstop=5         " Number of spaces to use for displaying tabs
set shiftwidth=2      " Number of spaces to use for autoindenting
set softtabstop=2     " When <BS>, pretend a tab is removed, even if spaces
set expandtab         " Expand tabs to spaces (overloadable by file type later)
set smartindent       " Increases indent on the next line for '{' and others

"autocmd Filetype ruby     setlocal ts=2 sts=2 sw=2 expandtab
"autocmd Filetype yaml     setlocal ts=2 sts=2 sw=2 expandtab
"autocmd Filetype puppet   setlocal ts=2 sts=2 sw=2 expandtab
"autocmd Filetype markdown setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype sh setlocal ts=4 noexpandtab

"==============================================================================
" Add "C-p" insert paste mode toggle for pasting indented code into console VIM
"------------------------------------------------------------------------------

nnoremap <C-p> :set invpaste paste?<CR>
set pastetoggle=<C-p>
set showmode

"==============================================================================
" Forced file types
"------------------------------------------------------------------------------

"au! BufRead,BufNewFile *.pp  setfiletype ruby "for Puppet

"==============================================================================
" If none found file types
"------------------------------------------------------------------------------
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  "au! BufRead,BufNewFile *.ext  setfiletype type
augroup END

"==============================================================================
" Debian/Ubuntu options
"------------------------------------------------------------------------------
"let g:ackprg="ack-grep -H --nocolor --nogroup --column"

"==============================================================================
" Source the vimrc file after saving it; Map leader-v to edit
"------------------------------------------------------------------------------
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

"==============================================================================
" When editing a file, always jump to the last known cursor position
"------------------------------------------------------------------------------
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

"==============================================================================
"
"------------------------------------------------------------------------------

