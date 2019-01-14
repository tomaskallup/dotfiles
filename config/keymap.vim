" Disable arrow keys
map  <up>    :echoerr "What are you doing?"<cr>
map  <down>  :echoerr "What are you doing?"<cr>
map  <left>  :echoerr "What are you doing?"<cr>
map  <right> :echoerr "What are you doing?"<cr>

" Change leader key to ","
let mapleader="\<space>"

" Setup custom shortcuts
map K gt
map J gT
" Remove highlights from search with ,f
map <leader>f :noh<CR>

map <leader>w :w<CR>
map <leader>q :q<cr>
map <leader>Q :qall<CR>
map <leader>x :x<CR>
map <leader>X :xall<CR>
map <leader>n :tabnew<CR>
map <leader>s :Startify<CR>

map <leader>ad :ALEDetail<CR>
map <leader>af :ALEFix<CR>

ino jk <esc>
ino kj <esc>
cno jj <c-c>
vno v <esc>

" Reindent whole file and go back to curosr
map <leader>= gg=G``
" Copy whole file and go back to curosr
map <leader>y ggyG``

nmap , <Plug>(easymotion-overwin-f)
nmap , <Plug>(easymotion-overwin-f2)

" Leader + q closes all windows in diffmode
if &diff
    map <leader>q :qall<CR>
endif

nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

" NERDtree settings
map <C-n> :NERDTreeFind<CR>
map m :NERDTreeToggle<CR>
let NERDTreeMapActivateNode='l'
let NERDTreeMapCloseChildren='h'

" LSP
nmap <silent> gd :LspDefinition<CR>
nmap <silent> gi :LspImplementation<CR>
nmap <silent> gr :LspReferences<CR>
nmap <leader>i :LspCodeAction<CR>

" use <tab> for trigger completion and navigate next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Tagbar
nmap <leader>tb :TagbarToggle<CR>

" Asyncomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
