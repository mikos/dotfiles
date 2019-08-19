" .vimrc
" Author: Mike Carter <mike@mikos.co.uk>

" Misc --------------------------------------------------------------------- {{{

set shell=/bin/bash\ --login

" }}}
" Plugins ------------------------------------------------------------------ {{{

set nocompatible
call plug#begin('~/.vim/plugged')

" deoplete
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" Plug 'alvan/vim-closetag'
Plug 'cakebaker/scss-syntax.vim'
Plug 'chriskempson/base16-vim', {'do': 'git checkout dict_fix'}
" Plug 'edkolev/tmuxline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'ElmCast/elm-vim'
" Plug 'evidens/vim-twig'
Plug 'fatih/vim-go'
Plug 'gberenfield/cljfold.vim'
Plug 'godlygeek/tabular'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-sexp'
Plug 'haya14busa/incsearch.vim'
" Plug 'itchyny/calendar.vim'
" Plug 'itspriddle/vim-jquery'
Plug 'luochen1990/rainbow'
Plug 'junegunn/fzf.vim'
" Plug 'lepture/vim-jinja'
" Plug 'leshill/vim-json'
" Plug 'losingkeys/vim-niji'
Plug 'majutsushi/tagbar'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
" Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
" Plug 'msanders/snipmate.vim'
Plug 'mxw/vim-jsx'
Plug 'nanotech/jellybeans.vim'
" Plug 'othree/html5.vim'
" Plug 'osyo-manga/vim-over'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'Raimondi/delimitMate'
Plug 'rlue/vim-fold-rspec'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
" Plug 'sjl/badwolf'
Plug 'slashmili/alchemist.vim'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
" Plug 'vim-scripts/matchit.zip'
" Plug 'vim-scripts/paredit.vim'
Plug 'vim-scripts/vimclojure'
" Plug 'vim-utils/vim-ruby-fold'
Plug 'w0rp/ale'

Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

call plug#end()
filetype plugin indent on
set rtp+=~/.fzf

" }}}
" Basic Options ------------------------------------------------------------ {{{

set encoding=utf-8
" set modelines=0
set autoindent
set showmode
set showcmd
set hidden
set visualbell t_vb=
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set nonumber
set norelativenumber
set laststatus=2
set history=1000
set undofile
set undoreload=10000
" set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set lazyredraw
set matchtime=3
set showbreak=↪
set splitbelow
set splitright
set autowrite
set autoread
set shiftround
set title
set linebreak
set colorcolumn=+1

" Share OS clipboard
set clipboard=unnamed

" Ensure UTF-8
set encoding=utf-8 nobomb
scriptencoding utf-8

let mapleader = ","
let maplocalleader = "\\"

" Trailing whitespace {{{
" Only shown when not in insert mode so I don't go insane.

augroup trailing
  au!
  au InsertEnter * :set listchars-=trail:⌴
  au InsertLeave * :set listchars+=trail:⌴
augroup END

" }}}
" Wildmenu completion {{{
set wildmenu
set wildmode=list:longest

set wildignore+=.git                                  " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg        " binary images
set wildignore+=*.DS_Store                            " OS X

set wildignore+=wp-admin,wp-includes                  " WordPress
set wildignore+=node_modules                          " NPM stuff
" }}}
" Tabs, spaces, wrapping {{{

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set wrap
set textwidth=80
set formatoptions=qrn1j
set colorcolumn=+1

au Filetype elm setl tabstop=4 shiftwidth=4 softtabstop=4

" }}}
" Backups {{{

set backup                        " enable backups
set noswapfile                    " it's 2013, Vim.

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

"}}}
" Colour scheme {{{

syntax on
set background=dark
let base16colorspace=256
colorscheme base16-monokai
" }}}

" clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" clean trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Toggle [i]nvisible characters
nnoremap <leader>i :set list!<cr>
" }}}
" Searching and movement --------------------------------------------------- {{{

" Use same regexes.
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

set scrolloff=3
set sidescroll=1
set sidescrolloff=10

set virtualedit+=block

noremap <silent> <leader>s :noh<cr>:call clearmatches()<cr>

runtime macros/matchit.vim

nnoremap D d%


" Jumping to tags.
"
" Basically, <c-]> jumps to tags (like normal) and <c-\> opens the tag in a new
" split instead.
"
" Both of them will align the destination line to the upper middle part of the
" screen.  Both will pulse the cursor line so you can see where the hell you
" are.  <c-\> will also fold everything in the buffer and then unfold just
" enough for you to see the destination line.
function! JumpToTag()
    execute "normal! \<c-]>mzzvzz15\<c-e>"
    execute "keepjumps normal! `z"
    Pulse
endfunction
function! JumpToTagInSplit()
    execute "normal! \<c-w>v\<c-]>mzzMzvzz15\<c-e>"
    execute "keepjumps normal! `z"
    Pulse
endfunction
nnoremap <c-]> :silent! call JumpToTag()<cr>
nnoremap <c-\> :silent! call JumpToTagInSplit()<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Directional Keys {{{

" It's 2013.
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" }}}


" }}}
" Folding ------------------------------------------------------------------ {{{

set foldlevelstart=0

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

nnoremap zO zczO

function! MyFoldText() " {{{
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" Go {{{

augroup ft_go
  au!
  " au BufRead,BufNewFile *.go set ft=go
  au FileType go setlocal foldmethod=syntax foldnestmax=1
  " au FileType go setlocal foldmethod=marker foldmarker={,} foldnestmax=1
  au FileType go setlocal ts=4 sts=4 sw=4 expandtab
augroup END


" }}}
" JavaScript {{{

augroup ft_javascript
  au!
  au BufRead,BufNewFile *.js set ft=javascript
  au FileType javascript setlocal foldmethod=syntax foldnestmax=2
augroup END


" }}}
" JSX {{{

augroup ft_jsx
  au!
  au BufRead,BufNewFile *.jsx set ft=javascript.jsx
  au FileType javascript.jsx setlocal foldmethod=marker
  au FileType javascript.jsx setlocal foldmarker={,}
augroup END


" }}}
" Mutt {{{

augroup ft_muttrc
  au!
  au BufRead,BufNewFile *.muttrc set ft=muttrc
  au FileType muttrc setlocal foldmethod=marker foldmarker={{{,}}}
augroup END

" }}}
" Vim {{{

augroup ft_vim
  au!

  au FileType vim setlocal foldmethod=marker keywordprg=:help
  au FileType help setlocal textwidth=78
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" }}}

" }}}
" Plugin options ----------------------------------------------------------- {{{

" Airline {{{
"
let g:airline_theme = 'base16'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#ale#enabled = 1

" }}}
" ALE {{{
let g:ale_linters = {
      \ 'go': ['golangci-lint'],
      \ 'javascript': ['eslint'],
\}
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_set_loclist = 0
let g_ale_set_quickfix = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <leader>e <Plug>(ale_detail)
" }}}
" Calendar {{{

let g:calendar_google_calendar = 1

" }}}
" CljFold {{{
let g:clojure_foldwords = "def,defn,defmacro,defmethod,defschema,defprotocol,defrecord,deftest"
" }}}
" Deoplete {{{

let g:deoplete#enable_at_startup = 1

" }}}
" Fugitive {{{

nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>

" }}}
" Gist {{{
"
let g:gist_clip_command = 'xclip -selection clipboard'

" }}}
" Incsearch {{{

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" }}}
" NERD Tree {{{

" Shortcut for NERDTreeToggle
nmap <leader>nt :NERDTreeToggle <CR>

" Show hidden (dot) files
let NERDTreeShowHidden=1

" Show bookmarks by default
let NERDTreeShowBookmarks=1

" }}}
" Rainbow {{{
let g:rainbow_active = 1
let g:rainbow_conf = {
  \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
  \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
  \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
  \   'separately': {
  \     '*': 0,
  \     'clojure': {},
  \   }
  \ }
" }}}
" Syntastic {{{
" set statusline+=%#warningmsg#
" set statusline+=${SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
"
" let g:syntastic_javascript_checkers=['eslint']
" let g:syntastic_javascript_eslint_exec='eslint_d'
" }}}
" Vim Go {{{
nnoremap <leader>a :cclose<CR>
autocmd Filetype go nmap <leader>gb <Plug>(go-build)
autocmd Filetype go nmap <leader>gr <Plug>(go-run)
autocmd Filetype go nmap <leader>gt <Plug>(go-test)
autocmd Filetype go nmap <leader>gc <Plug>(go-coverage-toggle)
autocmd Filetype go nmap <leader>gd <Plug>(go-doc)
" }}}

"}}}
" Other keybindings -------------------------------------------------------- {{{

nnoremap <leader><Space> :call ToggleAllFolds()<CR>

" CtrlP
" nnoremap <leader>t :CtrlP<CR>
" nnoremap <leader>b :CtrlPBuffer<CR>
" nnoremap <leader>r :CtrlPMRUFiles<CR>

nnoremap <leader>f :Goyo<CR>
nnoremap <leader>F :Goyo<CR>:Limelight!!<CR>

" FZF
nnoremap <leader>t :Files<CR>
nnoremap <leader>b :Buffers<CR>

nnoremap <leader>o :OverCommandLine<CR>

" fold navigation
nnoremap <C-j> zj
nnoremap <C-k> zk

function! ToggleAllFolds()
  if &foldlevel > 0
    let &foldlevel=0
  else
    let &foldlevel=20
  endif
endfunction

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind \ to grep shortcut
nnoremap \ :Rg<CR>

" evaluate top-level form
au BufEnter *.clj nnoremap <buffer> cpt :Eval<CR>

" show last evaulation in temp file
au BufEnter *.clj nnoremap <buffer> cpl :Last<CR>

" }}}
