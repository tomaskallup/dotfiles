set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Lokaltog/vim-easymotion' " Fast cursor jumping in files
Plugin 'scrooloose/nerdtree' " Nice file explorer inside vim
Plugin 'Xuyuanp/nerdtree-git-plugin' " Show git changes in NERDtree
Plugin 'vim-airline/vim-airline' " Airline bar for coziness
Plugin 'vim-airline/vim-airline-themes' " Airline themes
Plugin 'JulesWang/css.vim' " Better CSS support (for highlight)
Plugin 'scrooloose/syntastic' " Syntax checker
Plugin 'tpope/vim-fugitive' " GIT integration using :Gcommand
Plugin 'ryanoasis/vim-devicons' " Nice file icons
Plugin 'othree/html5.vim' " HTML5 tags
Plugin 'pangloss/vim-javascript' " Better JS syntax & indent
Plugin 'lumiliet/vim-twig' " Twig syntax
Plugin 'groenewege/vim-less' " Less syntax
Plugin 'tmhedberg/matchit' " Match HTML open/close tag, support for % on tag
Plugin 'yggdroot/indentline' " Show indented lines
Plugin 'ap/vim-css-color' " Color preview in CSS
Plugin 'digitaltoad/vim-pug' " Pug/Jade support
Plugin 'jiangmiao/auto-pairs' " Better bracket, qoute controll

call vundle#end()            " required
filetype plugin indent on    " required

" Basic VIM settings
set showcmd
set showmode
set title
set number
set relativenumber
set ruler
set cursorline
"set showbreak=^U2026
set laststatus=2 " Enable the status bar to always show
set hidden " Set hidden to allow buffers to be browsed
set breakindent " Make word wrapping behave like it does in every other sane text editor
set hlsearch " Highlight search results
set incsearch " Make search jump:
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoread " Make Vim automatically open changed files (e.g. changed after a Git commit)
au FocusGained,BufEnter * :silent! !

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent " always set autoindenting on
set noesckeys " (Hopefully) removes the delay when hitting esc in insert mode
set ttimeout " (Hopefully) removes the delay when hitting esc in insert mode
set ttimeoutlen=1 " (Hopefully) removes the delay when hitting esc in insert mode
set tabstop=8 " The default is 8 which is MASSIVE!!
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set wildmenu " visually autocomplete the command menu
set lazyredraw " only redraw when needed
set ttyfast " sends more characters to the screen for fast terminal
set showmatch " highlight matching [{()}]
set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested folders max
set shiftwidth=4
set wrap linebreak nolist
set virtualedit=onemore
set smartcase "don't ignore Captials when present
set ignorecase "don't need correct case when searching
set splitbelow " puts new splits to the bottom

syntax on
highlight Pmenu ctermbg=238 ctermfg=220

" Change leader key to ","
let mapleader=","

" Backups
set backup
set backupdir=~/.vim/SWP
set directory=~/.vim/SWP
set writebackup

set scrolloff=5

" Setup custom shortcuts
map <F6> :tabp<CR>
map <F7> :tabn<CR>
map <F8> :tabclose<CR>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
" Remove highlights from search with ,ev
map <leader>f :noh<CR>

" Disable default key-mappings
let g:EasyMotion_do_mapping = 0

" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
nmap <Space> <Plug>(easymotion-overwin-f)

" Need one more keystroke, but on average, it may be more comfortable.
nmap <Space> <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" NERDtree settings
map <C-n> :NERDTreeFind<CR>
map <C-m> :NERDTreeToggle<CR>
let NERDTreeMapActivateNode='l'
let NERDTreeMapCloseChildren='h'

let NERDTreeAutoDeleteBuffer = 1

" Change colors of NERDtree
hi Directory guifg=#5fff87 ctermfg=84
hi NERDTreeOpenable guifg=#00ff00 ctermfg=green
hi NERDTreeClosable guifg=#af0000 ctermfg=124

" Character encoding
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,latin1
endif

" Highlight .tpl files as TWIG
au BufNewFile,BufRead *.tpl set filetype=html.twig

let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_html_tidy_ignore_errors = [ 'discarding unexpected </a>', 'trimming empty <span>', 'trimming empty <li>', 'trimming empty <button>' ]

let g:html_indent_inctags = "html,body,head,tbody,span,b,a,div"

" Airline settup
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme="kolor"
let g:airline#extensions#tabline#enabled = 1 "enable the tabline
let g:airline#extensions#tabline#fnamemod = ':t' " show just the filename of buffers in the tab line
let g:airline_detect_modified=1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Disable arrow keys
map  <up>    <nop>
map  <down>  <nop>
map  <left>  <nop>
map  <right> <nop>

" Remember cursor pos
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Ignore the node_modules folder and all its subfolders
set wildignore+=**/node_modules/**

" Set the default clipboard
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" Highlight current line number
hi CursorLineNR cterm=bold ctermfg=220
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold ctermfg=220
augroup END

" Setup GUI
set guifont=SauceCodePro\ Nerd\ Font:h14
" Make the background easier to see in Gui Vim
if has('gui_running')
    set background=light
else
    set background=dark
endif

" Remove whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

set nocompatible
