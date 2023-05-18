let g:python_recommended_style = 0
filetype plugin on

set showcmd
set showmode
set number
set relativenumber
set hidden
set breakindent
set hlsearch
set incsearch
set autoread
set tabstop=2
set expandtab
set shiftwidth=2
set smarttab
set showmatch
set foldenable
set foldmethod=manual
set wrap
set linebreak
set formatoptions+=l
set formatoptions-=t
set virtualedit=onemore
set ignorecase
set smartcase
set splitbelow
set splitright
set updatetime=500
set title
set titleold="st"
set list
set listchars="tab:> ,trail:-,extends:#,nbsp:+"
set backupdir=~/.vim/SWP
set directory=~/.vim/SWP
set writebackup
set backupcopy=yes
set undofile
set undodir=$HOME/.vim/undo
set undolevels=150
set scrolloff=5
set wildignore+=**/node_modules/**
set gdefault
set wildmenu
set wildmode=longest:full,full
set grepprg=ag\ --vimgrep
set spelllang=en,cs
set diffopt=internal,filler,closeoff,algorithm:histogram,linematch:50

" Set completeopt to have a better completion experience
"set completeopt=menuone,noinsert,noselect,preview
set completeopt=menuone,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Highlight from start of file
autocmd BufEnter * :syntax sync fromstart

set clipboard+=unnamedplus
set fileencoding=utf-8

let g:html_indent_inctags = "html,body,head,tbody,div"

" Remember cursor pos
autocmd BufReadPost *
  \  if line("'\"") > 1 && line("'\"") <= line("$") |
  \    exe "normal! g`\"" |
  \  endif

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

augroup LocalConfig
  autocmd VimEnter,BufEnter * lua require'localconfig'.check()
augroup END

" Make sure python uses 4 spaces for tab
autocmd Filetype python setlocal ts=4 sw=4 expandtab

let g:vimsyn_embed = "lPr"
