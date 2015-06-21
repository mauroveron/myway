set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-jdaddy'
Plugin 'tpope/vim-commentary'
Plugin 'kien/ctrlp.vim'
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'godlygeek/tabular'
Plugin 'mattn/emmet-vim'

call vundle#end()

syntax on
set nu

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" This fixes small delay on terminal when using capital O
set ttimeoutlen=50

" general editor options {{{
let mapleader=','
set modeline
set noswapfile

set statusline=%<%2*%f%h%1*%m%2*%r%h%w%y\ %*%{&ff}\ %=\ %{fugitive#statusline()}\ col:%c%V\ asc:%B\ pos:%o\ lin:%l\,%L\ %P
set laststatus=2

set pastetoggle=<F3>

set hidden

set foldmethod=marker
set foldlevel=99
set encoding=utf-8

" search
set ignorecase
set smartcase
set incsearch
set hls
set gdefault     "default to globl search & replace

set wildmode=longest,list
set showmatch
set showcmd
set shortmess=at

set scrolloff=3

set wildignore=*.o,*.obj,*.swp,*.bak,*.pyc,*~,build,cache,*/sites/default/files,tmp
set wildignore+=*/vendor/**
set wildignore+=*/node_modules/**


" Use Perl's regex on searches
nnoremap / /\v
vnoremap / /\v

set nowrap "do not wrap by default
" move to the next editor line for wrapped lines
nnoremap j gj
nnoremap k gk

filetype plugin indent on
" fix for vim setting ft=modula2 on *.md files
au BufNewFile,BufReadPost *.md setl ft=markdown tw=80
"}}}

" look and feel {{{
"let g:solarized_termcolors=256
"set t_Co=256
colorscheme solarized
set cursorline

set listchars=tab:▸\ ,eol:¬,trail:·
"set cursorline
"set nonu
map <leader>b :set nu!<CR>
set title " show filename in titlebar / terminal
" }}}

" general editing tweaks {{{
set backspace=indent,eol,start        " allow backspacing over autoindent, linke breaks and start of insert
set nowrap

set autoindent

" default indentation is two spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
" }}}

" auto-completion {{{
set completeopt=menuone,preview
" }}}

" helpful leader shortcuts {{{
map <leader>q :q<cr>
map <leader>d :bd<cr>
map <leader>ca :1,300bd<cr>

map <leader>f :NERDTree<cr>
map <leader><space> :noh<cr>
map <leader>l :set list!<cr>
map <leader>o :TagbarToggle<cr>

map <leader>s :%:<C-R><C-W>:
vmap <leader>s :%s:<C-R><C-W>:

" from vimcasts.org/e/14
" edit file taking the path to the current active buffer into account.
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
" }}}

" other mappings {{{
" use Q to format paragraph
vmap Q gq
nmap Q gqap
" }}}

"autocmd vimenter * if !argc() | NERDTree | endif

autocmd BufNewFile,BufRead,BufEnter TODO.md setf todo

" Resize splits when the window is resized
au VimResized * :wincmd =

" Cursorline {{{
" Only show cursorline in the current window and in normal mode.

augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" }}}

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

" Trailing whitespace {{{
" Only shown when not in insert mode so I don't go insane.

augroup trailing
  au!
  au InsertEnter * :set listchars-=trail:⌴
augroup END
" }}}

" Fuck you, help key.
noremap  <F1> <nop>
inoremap <F1> <nop>

" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Marks and Quotes
noremap ' `

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Don't move on *
"nnoremap * *<c-o>

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <leader>v <C-w>v
noremap <leader>t :tabnew<CR>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Re-select last pasted text
nnoremap gp `[v`]

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

set lazyredraw
set ttyfast

" More natural split behavior
"set splitbelow
set splitright

if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

" Tabular.vim leader mappings
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>

set relativenumber

" CtrlP configuration
let g:ctrlp_buftag_ctags_bin = 'ctags'
let g:ctrlp_extensions = ['funky']
"let g:ctrlp_max_files=0
let g:ctrlp_match_func = { 'match': 'matcher#cmatch' }
"let g:ctrlp_extensions = ['tag', 'buffertag']
"@let g:ctrlp_user_command = "find %s -type f | egrep -v '/\.(git|hg|svn)|solr|tmp/' | egrep -v '\.(png|exe|jpg|gif|jar|class|swp|swo|log|gitkep|keepme|so|o)$'"
"let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_buftag_types = {
\ 'php'     : '--PHP-kinds=cf',
\ }

nmap <C-e> :CtrlPFunky<CR>

let g:UltiSnipsEditSplit = 'vertical'


" vim:fdm=marker:
