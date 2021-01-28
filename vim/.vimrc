" Load plugins
" forest-night best color scheme
" vim-polyglot to detect and format almost every language

call plug#begin('~/.vim/plugged')

Plug 'sainnhe/forest-night'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
Plug 'pedrohdz/vim-yaml-folds'

call plug#end()

set nocompatible	" force VIM functionality
set encoding=utf8	" proper text encoding
set nowrap		" Prevent text wrapping on screen
set nofoldenable	" Prevent folding from appearing by default
set nu			" Enable line numbers
set cursorline		" Enable highlighting of current line
set termguicolors	" Enable 256 color availability
syntax on		" Enable syntax highlighting

" Set up indent and edit behavior for Python
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
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

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw,*.yaml match BadWhitespace /^\t\+/

" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.yaml match BadWhitespace /\s\+$/

" The configuration options should be placed before `colorscheme forest-night`
let g:forest_night_enable_italic = 1
let g:forest_night_disable_italic_comment = 1

" Set color scheme
colorscheme forest-night

" set tab / indent guides
set list
set listchars=tab:>-
