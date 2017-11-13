scriptencoding utf-8
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

set autoread
au CursorHold * checktime

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1

let mapleader = ","
let g:syntastic_javascript_checkers = ['jshint']
let g:html_indent_tags = 'li\|p'
let g:netrw_liststyle=3
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:mustache_abbreviations = 1
let g:tmuxline_separators = {
    \'left' : ' ♩',
    \'left_alt': ' ♩ ',
    \'right' : ' ♩ ',
    \'right_alt' : ' ♩ ',
    \'space' : ' '}
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'z'    : '#H'}
let g:airline_theme = 'papercolor'
let g:airline_left_sep = ' ♩ '
let g:airline_right_sep = ' ♩ '
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|bower_components\|jest_*'

map <leader>/ <plug>NERDCommenterToggle<CR>
map  / <Plug>(easymotion-sn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
map <Leader>= <C-w>=
map <Leader>n :NERDTreeToggle<CR>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

omap / <Plug>(easymotion-tn)

nmap <leader>a :Ack! 
nmap <leader>o :only<cr>
nmap <Leader>bb :ls<CR>:buffer<Space>

imap <c-f> <Plug>snipMateNextOrTrigger

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

nnoremap <Leader>tn :tabnew<CR>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Color setting
filetype plugin indent on
colorscheme preto

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

augroup vimrcEx
  autocmd!

  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd FileType markdown setlocal spell
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType javascript set filetype=javascript.jsx
  autocmd FileType css,scss,sass setlocal iskeyword+=-
  autocmd FileType html,haml,elixir setlocal textwidth=400
augroup END

autocmd BufNewFile * :ClearAllCtrlPCaches
