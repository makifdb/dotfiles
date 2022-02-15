if &shell =~# 'fish$'
    set shell=sh
endif

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'fatih/vim-go'
Plug 'Raimondi/delimitMate'
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser.vim'
Plug 'dag/vim-fish'

call plug#end()

set encoding=utf-8
set mouse=a
set number
set showcmd
set noswapfile
set nobackup
set autowrite
set hidden
set completeopt=menu,menuone
set updatetime=300
set maxmempattern=20000
set viminfo='1000

syntax enable

autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2

autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2

nnoremap <space> zz

let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 0

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=1
