"### Dependencies
"
" curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
" python get-pip.py --user
" pip3 install --user pynvim
"
" yarn global add prettier
" yarn global add javascript-typescript-langserver
" yarn global add typescript-language-server
" yarn global add vscode-css-languageservice
" yarn global add vscode-html-languageservice
" yarn global add vscode-json-languageservice
"
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
"###

call plug#begin()

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript']}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'bling/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cocopon/iceberg.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'danro/rename.vim'
Plug 'easymotion/vim-easymotion'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/fzf'
Plug 'leafgarland/typescript-vim', { 'for': ['typescript']}
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline-themes'
Plug 'jparise/vim-graphql'

call plug#end()

filetype plugin indent on

scriptencoding utf-8
set nohlsearch
set encoding=utf-8
set nocompatible
set pastetoggle=<F2>
set backspace=2
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set laststatus=2
set autowrite
set scrolloff=10
set wildmenu
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set list listchars=tab:»·,trail:·
set colorcolumn=+1
set number
set numberwidth=5
set splitbelow
set splitright
set spellfile=$HOME/.vim-spell-en.utf-8.add
set t_Co=256
set cursorline
set relativenumber
set wildignore+=*/_build/*,*/deps/*
set visualbell
set signcolumn=no
set clipboard=unnamedplus
colorscheme iceberg

"### General Config
let mapleader = ","
"###

"### Deoplete Config
" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1
"###

"### LanguageClient Config
" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'typescript.tsx': ['typescript-language-server', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'javascript': ['javascript-typescript-stdio'],
		\ 'html': ['html-languageserver', '--stdio'],
		\ 'css': ['css-languageserver', '--stdio'],
		\ 'json': ['json-languageserver', '--stdio'],
    \ }
let g:LanguageClient_loggingLevel = 'DEBUG'
"###

"### Airline Config
let g:airline_theme = 'minimalist'
" unicode symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'
"###

"### Ctrp Config
let g:ctrlp_custom_ignore = 'output\|node_modules\|DS_Store\|git\|bower_components'
let g:ctrlp_show_hidden = 1
"###

"### Neoformat Config
let g:neoformat_run_all_formatters = 1
"###

"### Map config
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

nnoremap <Leader>tn :tabnew<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Use tabs to scroll through autocomplete items
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"

map <leader>/ <plug>NERDCommenterToggle :normal ^f<space><cr>
map <Leader>n :NERDTreeToggle<CR>

map  / <Plug>(easymotion-sn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
omap / <Plug>(easymotion-tn)
"###

"### Customize behavior by extension
augroup vimrcEx
  autocmd!

  autocmd BufWritePre *.js Neoformat
  autocmd BufWritePre *.jsx Neoformat
  autocmd BufWritePre *.ts Neoformat
  autocmd BufWritePre *.tsx Neoformat
  autocmd BufWritePre *.css Neoformat

  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufNewFile,BufRead Dockerfile* set filetype=dockerfile
  autocmd FileType markdown setlocal spell
  autocmd FileType javascript set filetype=javascript.jsx
augroup END
"###

