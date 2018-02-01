set nocompatible              " be iMproved, required

call plug#begin()

" --------------------------------------------------------------------- "
"  Better movement plugins                                              "
" --------------------------------------------------------------------- "
Plug 'Lokaltog/vim-easymotion' " Fast cursor jumping in files
Plug 'scrooloose/nerdtree' " Nice file explorer inside vim
Plug 'jlanzarotta/bufexplorer' " Better buffer management
Plug 'Xuyuanp/nerdtree-git-plugin' " Show git changes in NERDtree
Plug 'tmhedberg/matchit' " Match HTML open/close tag, support for % on tag
Plug 'ctrlpvim/ctrlp.vim' " File finder
Plug 'xolox/vim-easytags' " OPOP
Plug 'xolox/vim-misc' " ^ He needs it

" -------------------------------------------------------------------- "
"  Design changing plugins                                             "
" -------------------------------------------------------------------- "
Plug 'itchyny/lightline.vim' " Nice bar
Plug 'ryanoasis/vim-devicons' " Nice file icons
Plug 'mhinz/vim-startify' " Cool startup screen

" -------------------------------------------------------------------- "
"  Syntax and autocomplete                                             "
" -------------------------------------------------------------------- "
Plug 'JulesWang/css.vim' " Better CSS support (for highlight)
Plug 'othree/html5.vim' " HTML5 tags
Plug 'lumiliet/vim-twig' " Twig syntax
Plug 'groenewege/vim-less' " Less syntax
Plug 'elzr/vim-json' " Json syntax fix
Plug 'pangloss/vim-javascript' " Better JS syntax & indent
Plug 'mxw/vim-jsx' " JSX syntax
"Plug 'flowtype/vim-flow' " Flow support
Plug 'ap/vim-css-color'
"Plug 'kchmck/vim-coffee-script'

"Plug 'JamshedVesuna/vim-markdown-preview' " Markdown preview
"Plug 'HerringtonDarkholme/yats.vim' " TypeScript
"Plug 'blueyed/smarty.vim' " Smarty
Plug 'digitaltoad/vim-pug' " Pug/Jade support

"Plug 'Valloric/YouCompleteMe' " THIS GUY, OMG!
Plug 'maralla/completor.vim'
Plug 'ternjs/tern_for_vim' " JS support for external libs
Plug 'SirVer/ultisnips' " Fancy snippet loader, used by YouCompleteMe

" -------------------------------------------------------------------- "
"  Other general stuff                                                 "
" -------------------------------------------------------------------- "
Plug 'editorconfig/editorconfig-vim' " Time for some fun
Plug 'mattn/emmet-vim' " Html godlike
Plug 'sjl/gundo.vim' " Better undo
Plug 'w0rp/ale' " Linter lul
Plug 'tpope/vim-surround' " (o_o)

call plug#end()

" Basic VIM settings
set showcmd
set showmode
set title
set number
set relativenumber
set ruler
set laststatus=2 " Enable the status bar to always show
set hidden " Set hidden to allow buffers to be browsed
set breakindent " Make word wrapping behave like it does in every other sane text editor
set hlsearch " Highlight search results
set incsearch " Make search jump:
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoread " Make Vim automatically open changed files (e.g. changed after a Git commit)

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent " always set autoindenting on
set noesckeys " (Hopefully) removes the delay when hitting esc in insert mode
set ttimeout " (Hopefully) removes the delay when hitting esc in insert mode
set ttimeoutlen=1 " (Hopefully) removes the delay when hitting esc in insert mode
set tabstop=4 " The default is 8 which is MASSIVE!!
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set wildmenu " visually autocomplete the command menu
set lazyredraw " only redraw when needed
set ttyfast " sends more characters to the screen for fast terminal
set showmatch " highlight matching [{()}]
set nofoldenable " disable folding
set shiftwidth=4
set wrap linebreak nolist
set textwidth=0
set wrapmargin=0
set formatoptions+=l
set virtualedit=onemore
set smartcase "don't ignore Captials when present
set ignorecase "don't need correct case when searching
set splitbelow " puts new splits to the bottom
set splitright " and to right

set shortmess+=c "Disable annoying message from YCM

" Show tabs and spaces
set listchars=tab:›\ ,trail:-,extends:#,nbsp:.
set list

syntax on
highlight Pmenu ctermbg=8 ctermfg=14

" Custom 'Silent' commnad
command! -nargs=1 Silent
\   execute 'silent !' . <q-args>
\ | execute 'redraw!'

" Change leader key to ","
let mapleader="\<space>"

" Backups
set backup
set backupdir=~/.vim/SWP
set directory=~/.vim/SWP
set writebackup

" Undo directory
set undofile
set undodir=$HOME/.vim/undo
set undolevels=150

set scrolloff=5

" Setup custom shortcuts
map J gT
map K gt
map <F8> :bd<CR>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
" Remove highlights from search with ,f
map <leader>f :noh<CR>

map <leader>w :w<CR>
map <leader>q :q<cr>
map <leader>Q :qall<CR>
map <leader>x :x<CR>
map <leader>X :xall<CR>
map <leader>n :tabnew<CR>
map <leader>s :Startify<CR>
map <leader>p :lcd %:p:h<CR>

map <leader>g :GundoToggle<CR>

map <leader>r :Silent curl localhost:3000/reload/%:t <CR>

ino jk <esc>
ino kj <esc>
cno jj <c-c>
vno v <esc>

" Reindent whole file and go back to curosr
map <leader>= gg=G``
" Copy whole file and go back to curosr
map <leader>y ggyG``
" Paste and indent pasted text (not used)
"map <leader>p p=`]

" Disable default key-mappings
let g:EasyMotion_do_mapping = 0

" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
nmap , <Plug>(easymotion-overwin-f)

" Need one more keystroke, but on average, it may be more comfortable.
nmap , <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" NERDtree settings
map <C-n> :NERDTreeFind<CR>
map m :NERDTreeToggle<CR>
let NERDTreeMapActivateNode='l'
let NERDTreeMapCloseChildren='h'

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen = 1

" Close vim if nerdtree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Change colors
hi Directory guifg=#5fff87 ctermfg=3
hi NERDTreeOpenable guifg=#00ff00 ctermfg=12
hi NERDTreeClosable guifg=#af0000 ctermfg=1
hi WarningMsg cterm=bold ctermfg=1 ctermbg=16
hi type ctermfg=10
hi Visual ctermbg=5
hi Special ctermfg=11

hi link htmlTag Identifier
hi link htmlTagName statement
hi link htmlEndTag Identifier

" Fix XML colors
hi link xmlTag htmlTag
hi link xmlTagName htmlTagName
hi link xmlEndTag htmlEndTag

" Fix Flow
hi link jsFlowTypeKeyword Keyword

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

let g:html_indent_inctags = "html,body,head,tbody,span,b,a,div"

" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" Get rekt Airline - lightline is the new god
let g:lightline = {
    \ 'colorscheme': 'zupa',
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename' ] ],
    \   'right': [ [ 'fileformat', 'fileencoding', 'filetype' ], [ 'lineinfo' ], ['linter_warnings', 'linter_errors', 'linter_ok'] ]
    \ },
    \ 'component_expand': {
    \   'linter_warnings': 'LightlineLinterWarnings',
    \   'linter_errors': 'LightlineLinterErrors',
    \   'linter_ok': 'LightlineLinterOK'
    \ },
    \ 'component_function': {
    \   'modified': 'LightlineModified',
    \   'readonly': 'LightlineReadonly',
    \   'fugitive': 'LightlineFugitive',
    \   'filename': 'LightlineFilename',
    \   'fileformat': 'LightlineFileformat',
    \   'filetype': 'LightlineFiletype',
    \   'fileencoding': 'LightlineFileencoding',
    \   'mode': 'LightlineMode',
    \ },
    \ 'component_type': {
    \   'linter_warning': 'warning',
    \   'linter_errors': 'error',
    \ }
    \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call lightline#update()

" Disable arrow keys
map  <up>    :echoerr "What are you doing?"<cr>
map  <down>  :echoerr "What are you doing?"<cr>
map  <left>  :echoerr "What are you doing?"<cr>
map  <right> :echoerr "What are you doing?"<cr>

" Remember cursor pos
autocmd BufReadPost *
  \  if line("'\"") > 1 && line("'\"") <= line("$") |
  \    exe "normal! g`\"" |
  \  endif

" Ignore the node_modules folder and all its subfolders
set wildignore+=**/node_modules/**

" Set the default clipboard
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" Highlight current line number
hi CursorLineNR cterm=bold ctermfg=1

" Setup GUI
set guifont=SauceCodePro\ Nerd\ Font:h16

" Remove whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" YouCompleteMe settings
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \   'css' : [': '],
  \ }

let g:ycm_autoclose_preview_window_after_completion=1

" Ultisnips keybinds
let g:UltiSnipsExpandTrigger="<C-j>"

" Configure Completor
let g:completor_node_binary = '/usr/local/bin/node'

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" Tags
set tags=./.vimtags;,.vimtags;

" Vim-easytags
let g:easytags_file = '.vimtags'

" Update tags in background and don't interrupt the foreground processes
let g:easytags_async = 1

let g:startify_fortune_use_unicode = 1

let g:vim_json_syntax_conceal = 0

let g:jsx_ext_required = 0

let g:ale_linters = {
  \   'html': ['htmlhint'],
  \   'javascript': ['eslint'],
  \}

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

set nocompatible
