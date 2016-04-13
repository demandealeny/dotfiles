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
set textwidth=80
set colorcolumn=+1
set number
set numberwidth=5
set splitbelow
set splitright
set spellfile=$HOME/.vim-spell-en.utf-8.add
set background=dark
set t_Co=256
set cursorline
set relativenumber

let mapleader = ","
let g:syntastic_javascript_checkers = ['jshint']
let g:html_indent_tags = 'li\|p'
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:mustache_abbreviations = 1
let g:rspec_command = "Dispatch rr {spec}"
"let g:UltiSnipsExpandTrigger="<tab>"
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
let g:airline_theme = 'wombat'
let g:airline_left_sep = ' ♩ '
let g:airline_right_sep = ' ♩ '
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|bower_components'

map <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>
map <leader>/ <plug>NERDCommenterToggle<CR>
map  / <Plug>(easymotion-sn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
map <Leader>= <C-w>=
map  <C-0> 0gt
map  <C-1> 1gt
map  <C-2> 2gt
map  <C-3> 3gt
map  <C-4> 4gt
map  <C-5> 5gt
map  <C-6> 6gt
map  <C-7> 7gt
map  <C-8> 8gt
map  <C-9> 9gt

omap / <Plug>(easymotion-tn)

nmap <Leader>bb :ls<CR>:buffer<Space>
nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nmap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>
nmap \\ :w <CR>
nmap <leader>hs :set hlsearch! hlsearch?<CR>

imap <C-0> <Esc>0gt
imap <C-1> <Esc>1gt
imap <C-2> <Esc>2gt
imap <C-3> <Esc>3gt
imap <C-4> <Esc>4gt
imap <C-5> <Esc>5gt
imap <C-6> <Esc>6gt
imap <C-7> <Esc>7gt
imap <C-8> <Esc>8gt
imap <C-9> <Esc>9gt
imap <c-f> <Plug>snipMateNextOrTrigger

nnoremap <leader>c :! 
nnoremap <leader>l :ls<CR>
nnoremap <leader>sb :sb<space>
nnoremap <leader>vb :vertical sb<space>
nnoremap <leader>\ <c-^>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
map <Leader>p :!clear<cr>:call RunLastSpec()<CR>
map <Leader>a :!clear<cr>:call RunAllSpecs()<CR>
nnoremap <Leader>t :!clear<cr>:call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :!clear<cr>:call RunNearestSpec()<CR>
nnoremap <Leader>f :!clear<cr>:!rr spec/features<CR>
nnoremap <Leader>r :!clear<cr>:!rr spec/requests<CR>
nnoremap <Leader>u :!clear<cr>:!rr_ut<CR>
nnoremap <Leader>tn :tabnew<CR>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <leader>fef :normal! gg=G``<CR>

inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-p>

cnoremap <expr> <C-P> getcmdline()[getcmdpos()-2] ==# ' ' ? expand('%:p:h') : "\<C-P>"
"b

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

abbr bp binding.pry

" Color setting
filetype plugin indent on
colorscheme gotham256
"colorscheme molokai

hi MatchParen cterm=underline ctermbg=none ctermfg=none

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
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd FileType markdown setlocal spell
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
  autocmd FileType css,scss,sass setlocal iskeyword+=-
  autocmd FileType html,haml setlocal textwidth=9999
  autocmd FileType go set tabstop=4
  autocmd FileType go set shiftwidth=4
  autocmd FileType go set list listchars=tab:\ \ ,trail:·
  autocmd FileType go abbr fp fmt.Print
  autocmd FileType go abbr fpl fmt.Println
  autocmd FileType go abbr fpf fmt.Printf
  autocmd FileType go abbr wr w http.ResponseWriter, req *http.Request
augroup END

autocmd BufNewFile * :ClearAllCtrlPCaches

function! InsertTabWrapper()
  let col = col(".") - 1
  if !col || getline(".")[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-n>"
  endif
endfunction
