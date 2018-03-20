execute pathogen#infect()
syntax on
filetype plugin indent on
set relativenumber
set tabstop=4
set renderoptions=type:directx
set encoding=utf-8

nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>a

call plug#begin('~/vimfiles/plugged')

Plug 'jiangmiao/auto-pairs'

Plug 'Valloric/YouCompleteMe'

Plug 'ElmCast/elm-vim'
let g:polyglot_disabled = ['elm']

Plug 'ctrlpvim/ctrlp.vim'
set wildignore+=*\\node_modules\\*,*\\elm-stuff\\*

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='angr'

Plug 'w0rp/ale'
let g:airline#extensions#ale#enabled = 1
let g:ale_set_highlights = 0
call plug#end()
