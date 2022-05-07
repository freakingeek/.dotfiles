" Disable compatibility with vi
set nocompatible

" Enable type file detection
filetype on

" Enable plugins and load plugin for the detected file type
filetype plugin on

" Load an indent file for the detected file type
filetype indent on

" Turn syntax highlighting on
syntax on

" Add numbers to each line
set number

" Highlight cursor line
" set cursorline

" Set shift width to 2 spaces
set shiftwidth=2

" Set tab width to 2 columns
set tabstop=2

" Use space characters instead of tabs
set expandtab

" Do not let cursor scroll below or above N number of lines when scrolling
set scrolloff=8

" Do not wrap lines. Allow long lines to extend as far as the line goes
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch
