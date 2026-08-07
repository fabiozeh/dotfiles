set number
set hidden
set scrolloff=8
set tabstop=4
set shiftwidth=4
set softtabstop=4

set incsearch
set nohlsearch
set wildmenu
set mouse=a
set clipboard=unnamed,unnamedplus
set expandtab
let mapleader=" "
nnoremap <leader>. :bn<cr>
nnoremap <leader>, :bp<cr>
nnoremap <leader>n :enew<cr>
nnoremap <leader>w :bd<cr>
nnoremap <leader>ex :Explore<cr>
nnoremap <leader>fd :edit ~/.vimrc<cr>
inoremap jk <Esc>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
