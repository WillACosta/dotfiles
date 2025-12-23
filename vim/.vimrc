syntax enable
syntax on
set nocompatible
set encoding=utf8

filetype plugin on
filetype indent on

" colorscheme gruber-darker

set number
set relativenumber
set guicursor=""

set mouse=a
set wildmenu
set so=10
set ai
set si
set wrap
set ruler

" Mirror vim register to SO's clipboard
set clipboard=unnamedplus

" Replace and paste
xnoremap("<leader>p", "\"_dP")

set smartindent
set autoindent

set wildignore=.*
let NERDTreeShowHidden=1

set backspace=indent,eol,start
set smartcase
set hlsearch
set incsearch

set tabstop=2
set shiftwidth=2
set expandtab

set noundofile
set nobackup
set noswapfile

let mapleader = " "
map <leader>rv :e! ~/.vimrc<cr>
map <leader>pv :Ex<cr>
map <leader>w :w!<cr>
map <leader>q :q!<cr>
nmap <silent> <leader><CR> o<ESC>

" nnoremap K :m .-2<cr>==
" inoremap J <esc>:m .+1<cr>==gi
" inoremap K <esc>:m .-2<cr>==gi
" vnoremap J :m '>+1<cr>gv=gv
" vnoremap K :m '<-2<cr>gv=gv

" Remap control + d and u to center the code 
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")


" Move tabs

" CTRL-Tab is next tab
noremap <C-Tab> :<C-U>tabnext<CR>
inoremap <C-Tab> <C-\><C-N>:tabnext<CR>
cnoremap <C-Tab> <C-C>:tabnext<CR>

" CTRL-SHIFT-Tab is previous tab
noremap <C-S-Tab> :<C-U>tabprevious<CR>
inoremap <C-S-Tab> <C-\><C-N>:tabprevious<CR>
cnoremap <C-S-Tab> <C-C>:tabprevious<CR>

highlight Comment ctermfg=green

" netrw
let g:netrw_banner=0
let g:netrw_liststyle=3
nnoremap <c-b> <esc>:Lex<cr>:vertical resize 30<cr>
inoremap <c-b> <esc>:Lex<cr>:vertical resize 30<cr>

" {{{ Python
" hint: in the insert mode, type $r to expand return
" au FileType python inoremap <buffer> $r return
" au FileType python inoremap <buffer> $i import
" au FileType python inoremap <buffer> $p print
" au FileType python inoremap <buffer> $f #--- <esc>a
" au FileType python map <buffer> <leader>1 /class
" au FileType python map <buffer> <leader>2 /def
" au FileType python map <buffer> <leader>C ?class
" au FileType python map <buffer> <leader>D ?def
" au FileType python set cindent
" au FileType python set cinkeys-=0#
" au FileType python set indentkeys-=0#
" }}}

" {{{ yml section
au FileType yaml setl tabstop=2
au FileType yaml setl shiftwidth=2
" }}}"
