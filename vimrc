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

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

"==============================================================================
" Basic options
"------------------------------------------------------------------------------

set encoding=utf-8
set history=50      " Longer command history for q:
set vb              " No audible bell
let mapleader=","  " Remapped from \"
set laststatus=2    " Always show status bar for powerline
let g:Powerline_symbols = 'compatible'
let g:signify_vcs_list = [ 'git' ]
set ignorecase      " Searches are case insenstive by default
set smartcase       "     unless search contains Uppercase character
set wildmode=longest,list,full " more natural tab completion
set backspace=indent,eol,start
set wildmenu
set incsearch
set vb t_vb=

"==============================================================================
" Key Mappings
"------------------------------------------------------------------------------
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>sl :set list!<CR>
nmap <leader>g :Gstatus<CR>
imap <C-l> <Space>=><Space>
noremap <leader>y "+y
noremap <leader>yy "+Y
noremap <leader>p "+p
map <Leader>ct :!ctags -R .<CR>
map <Leader>h :TagbarToggle<CR>

" Rspec.vim mappings
map <leader>s :call RunCurrentSpecFile()<CR>
map <leader>n :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>

"==============================================================================
" Appearance options
"------------------------------------------------------------------------------

syntax on
set number             " Turn this off for copy with 'set nonumber'
if exists('+colorcolumn') " Marks the 80th character column
  set colorcolumn=80
endif
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
"if exists("did_load_filetypes")
  "finish
"endif
"augroup filetypedetect
  ""au! BufRead,BufNewFile *.ext  setfiletype type
"augroup END

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
" Load .vimrc.local if it exists (for easy colorscheme changes, etc.)
"------------------------------------------------------------------------------
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

