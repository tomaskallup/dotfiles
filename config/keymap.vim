" Disable arrow keys
map  <up>    :echoerr "What are you doing?"<cr>
map  <down>  :echoerr "What are you doing?"<cr>
map  <left>  :echoerr "What are you doing?"<cr>
map  <right> :echoerr "What are you doing?"<cr>

" Change leader key to ","
let mapleader="\<space>"

" Setup custom shortcuts
map J gT
map K gt
map <F8> :bd<CR>
nnoremap <leader>ev :e $MYVIMRC<CR>
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
map <leader>i :YcmCompleter FixIt<CR>

map <leader>g :GundoToggle<CR>

map <leader>ad :ALEDetail<CR>

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

" Change Completor keybind to replicate YCM
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
