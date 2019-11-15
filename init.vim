"### Dependencies
"
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
"
" Inside neovim:
"
" - :CocInstall coc-<plugin-name>
"###

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript']}
Plug 'bling/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cocopon/iceberg.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'danro/rename.vim'
Plug 'easymotion/vim-easymotion'
Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline-themes'
Plug 'jparise/vim-graphql'
Plug 'pbrisbin/vim-mkdir'

call plug#end()

filetype plugin indent on

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c
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

"### Airline Config
let g:airline_theme = 'minimalist'
" unicode symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
"###

"### Ctrp Config
let g:ctrlp_custom_ignore = 'output\|node_modules\|DS_Store\|git\|bower_components'
let g:ctrlp_show_hidden = 1
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

  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufNewFile,BufRead Dockerfile* set filetype=dockerfile
  autocmd FileType markdown setlocal spell
  autocmd FileType javascript set filetype=javascript.jsx
augroup END
"###

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-css',
  \ 'coc-emmet',
  \ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

