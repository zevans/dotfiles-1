set guioptions-=T         " Remove toolbar
set guioptions-=r         " Remove right scrollbar
set vb t_vb=

"==============================================================================
" Load .gvimrc.local if it exists (for easy colorscheme changes, etc.)
"------------------------------------------------------------------------------
if filereadable(glob("~/.gvimrc.local"))
    source ~/.gvimrc.local
endif

