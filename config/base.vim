filetype plugin on

" Basic VIM settings
set showcmd
set showmode
set number
set relativenumber
set laststatus=2 " Enable the status bar to always show
set hidden " Set hidden to allow buffers to be browsed
set breakindent " Make word wrapping behave like it does in every other sane text editor
set hlsearch " Highlight search results
set incsearch " Make search jump:
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoread " Make Vim automatically open changed files (e.g. changed after a Git commit)

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent " always set autoindenting on
set tabstop=2 " The default is 8 which is MASSIVE!!
set softtabstop=0
set expandtab
set shiftwidth=2
set smarttab
set wildmenu " visually autocomplete the command menu
set ttyfast " sends more characters to the screen for fast terminal
set nolazyredraw
set showmatch " highlight matching [{()}]
set nofoldenable " disable folding
set wrap linebreak
set textwidth=0
set wrapmargin=0
set formatoptions+=l
set formatoptions-=t
set virtualedit=onemore
set ignorecase " ignore case when searching
set smartcase " don't ignore Captials when present
set splitbelow " puts new splits to the bottom
set splitright " and to right
set synmaxcol=400 " Prevent long lines from ruining my life
set completeopt+=preview
set guicursor=n-v-c-sm:hor20,i-ci-ve:ver25,r-cr-o:hor20,a:Cursor
set updatetime=500
set title
set titleold=st

" Show tabs and spaces
set listchars=tab:›\ ,trail:-,extends:#,nbsp:.
set list

syntax on

" Backups
set backupdir=~/.vim/SWP
set directory=~/.vim/SWP
set writebackup
set backupcopy=yes

" Undo directory
set undofile
set undodir=$HOME/.vim/undo
set undolevels=150

set scrolloff=5

" Tags
set tags=./.vimtags;,.vimtags;

" Ignore the node_modules folder and all its subfolders
set wildignore+=**/node_modules/**

" Setup GUI
set guifont=SauceCodePro\ Nerd\ Font:h16

" Set language
language en_GB.UTF-8

" Fix session saving
set ssop-=options
set ssop-=folds

" Remove whitespaces on save
"autocmd BufWritePre * :%s/\s\+$//e

" Current workaround for long classes
autocmd BufReadPost *.tsx,*.ts,*.jsx,*.js :syntax sync fromstart

autocmd BufNewFile,BufRead calcurse-note.* :set filetype=markdown

" Set the default clipboard
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" Character encoding
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,latin1
endif

let g:html_indent_inctags = "html,body,head,tbody,span,b,a,div"

" Remember cursor pos
autocmd BufReadPost *
  \  if line("'\"") > 1 && line("'\"") <= line("$") |
  \    exe "normal! g`\"" |
  \  endif

" Custom function to get current synstack under cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Fix filetype for jsx files
au BufNewFile,BufRead *.jsx set filetype=javascript.jsx

" runtime macros/matchit.vim
