set nocompatible	" force VIM functionality
set encoding=utf8	" proper text encoding
set nowrap		" Prevent text wrapping on screen
set nofoldenable	" Prevent folding from appearing by default
set nu			" Enable line numbers
set cursorline		" Enable highlighting of current line
set termguicolors	" Enable 256 color availability
syntax on		" Enable syntax highlighting
filetype indent off	" turn off autoindent
set noai		" turn off autoindent

set list            	" set tab / indent guides
set listchars=tab:>-    " set tab / indent guides

" Set up indent and edit behavior for Python
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set fileformat=unix |

" Set up indent and edit behavior for YAML
au BufNewFile,BufRead *.yaml
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set foldmethod=indent
