set nocompatible                " be iMproved, required
filetype off                    " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Download plug-ins to the ~/.vim/plugged/ directory
call vundle#begin('~/.vim/plugged')
" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'lifepillar/vim-solarized8'

call vundle#end()
filetype plugin indent on

set encoding=utf8               " Proper text encoding
set nowrap                      " Prevent text wrapping on screen
set nofoldenable                " Prevent folding from appearing by default
set nu                          " Enable line numbers
set cursorline                  " Enable highlighting of current line
set termguicolors               " Enable 256 color availability
syntax on                       " Enable syntax highlighting
filetype indent off             " Turn off autoindent
set noai                        " Turn off autoindent

set list                        " Set tab / indent guides
set listchars=tab:>-            " Set tab / indent guides

set incsearch                   " Enable incremental search
set hlsearch                    " Enable highlight search

set termwinsize=12x0            " Set terminal size
set splitbelow                  " Always split below
set mouse=a                     " Enable mouse drag on window splits

set background=dark             " Dark or light
colorscheme solarized8_high     " Your favorite color scheme's name

" Set up indent and edit behavior for Python
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set fileformat=unix |
    \ set expandtab

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
