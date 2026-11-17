
" ==========================================
" Plugins
" ==========================================
call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'airblade/vim-gitgutter'
call plug#end()

" ==========================================
" Clean UI
" ==========================================

" Remove the separate sign column
" set signcolumn=no
set signcolumn=yes

" Remove unnecessary UI elements
set noruler
set noshowcmd
set laststatus=0

" Remove vertical split borders
set fillchars+=vert:\

" Make gutter match the editor background
highlight LineNr guibg=NONE ctermbg=NONE
highlight SignColumn guibg=NONE ctermbg=NONE
highlight FoldColumn guibg=NONE ctermbg=NONE

" ==========================================
" Editor
" ==========================================

syntax enable
syntax on
filetype plugin on
filetype indent on

set nocompatible
set encoding=utf-8
set number
set relativenumber
set cursorline
set mouse=a
set hidden
set wildmenu

set guicursor=""

set so=10
set ai
set si
"set wrap
set ruler

set wildignore=.*
let NERDTreeShowHidden=1

set backspace=indent,eol,start
set noundofile
set nobackup
set noswapfile

" Searching
set ignorecase
set smartcase
set incsearch
set hlsearch

" Indentation
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent

" Colors
set termguicolors
set background=dark

" ==========================================
" Markdown
" ==========================================
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 1
let g:vim_markdown_conceal_code_blocks = 0

augroup markdown_settings
    autocmd!
    autocmd FileType markdown setlocal conceallevel=2
    autocmd FileType markdown setlocal concealcursor=nc
    autocmd FileType markdown setlocal wrap linebreak
augroup END

" colorscheme gruber-darker
" Mirror vim register to SO's clipboard
set clipboard=unnamedplus

" Leader

" Replace and paste
xnoremap("<leader>p", "\"_dP")

" Leader key
let mapleader = " "

" map <leader>rv :e! ~/.vimrc<cr>
" map <leader>pv :Ex<cr>
" map <leader>w :w!<cr>
" map <leader>q :q!<cr>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Clear search highlight
nnoremap <leader>h :nohlsearch<CR>

" Navigate between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move tabs

" CTRL-Tab is next tab
noremap <C-Tab> :<C-U>tabnext<CR>
inoremap <C-Tab> <C-\><C-N>:tabnext<CR>
cnoremap <C-Tab> <C-C>:tabnext<CR>

" CTRL-SHIFT-Tab is previous tab
noremap <C-S-Tab> :<C-U>tabprevious<CR>
inoremap <C-S-Tab> <C-\><C-N>:tabprevious<CR>
cnoremap <C-S-Tab> <C-C>:tabprevious<CR>
