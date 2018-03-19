execute pathogen#infect()
syntax on
filetype plugin indent on
" set path+=**
set relativenumber

call plug#begin('~/vimfiles/plugged')

Plug 'jiangmiao/auto-pairs'

" Plug 'vim-syntastic/syntastic'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

Plug 'ElmCast/elm-vim'
let g:polyglot_disabled = ['elm']
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1

" let g:elm_syntastic_show_warnings = 1

Plug 'ctrlpvim/ctrlp.vim'
set wildignore+=*\\node_modules\\*,*\\elm-stuff\\*

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='angr'

Plug 'w0rp/ale'
let g:airline#extensions#ale#enabled = 1
call plug#end()
