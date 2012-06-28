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
"------------------------------------------------------------------------------

filetype off                               " Disable for Vundle load
set rtp+=~/.vim/bundle/vundle/             " Add Vundle subdir to run time path
call vundle#rc()                           " Enable vundle
Bundle 'altercation/vim-colors-solarized'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'Lokaltog/vim-powerline'
filetype plugin indent on                  " (Re)enable filetype and indenting

"==============================================================================
" Basic options
"------------------------------------------------------------------------------

set history=50      " Longer command history for q:
set vb              " No audible bell
let mapleader= ","  " Remapped from "\" for Command(,)T
set laststatus=2    " Always show status bar for powerline
"set t_Co=16        " Use in case of xterm sans 256 color

"==============================================================================
" Appearance options
"------------------------------------------------------------------------------

syntax on
set number             " Turn this off for copy with 'set nonumber'
set colorcolumn=80     " Marks the 80th character column
set background=dark
colorscheme solarized
:call togglebg#map("") " Required to call activate function

if has('gui_running')
  set background=light
endif
set guifont=Monaco:h18

"==============================================================================
" Tab and indent options
"------------------------------------------------------------------------------

set shiftwidth=2      " Number of spaces to use for autoindenting
set softtabstop=2     " When <BS>, pretend a tab is removed, even if spaces
set expandtab         " Expand tabs to spaces (overloadable by file type later)
set smartindent       " Increases indent on the next line for '{' and others

"==============================================================================
" Add "C-p" insert paste mode toggle for pasting indented code into console VIM
"------------------------------------------------------------------------------

nnoremap <C-p> :set invpaste paste?<CR>
set pastetoggle=<C-p>
set showmode

"==============================================================================
" Forced file types
"------------------------------------------------------------------------------

au! BufRead,BufNewFile *.pp  setfiletype ruby "for Puppet 

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
" 
"------------------------------------------------------------------------------
