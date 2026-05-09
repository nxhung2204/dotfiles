" Options
let mapleader="\\"
set termguicolors
set hidden
set ignorecase
set smartcase
set termguicolors
set number
set relativenumber
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set t_Co=256
set background=dark
set encoding=UTF-8
set clipboard=unnamedplus
syntax on

" Plugins
call plug#begin()
  Plug 'tpope/vim-surround'
  Plug 'morhetz/gruvbox'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
call plug#end()

colorscheme gruvbox

" fzf: use fd for file search, rg for grep
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude .git'
let g:fzf_preview_window = []

" Keymap
inoremap jk <ESC>
nnoremap <leader>e :Lexplore<CR>
nnoremap <leader>sf :Files<CR>
nnoremap <leader>sg :Rg<CR>
nnoremap <leader>sb :Buffers<CR>
