" Disable arrow keys
map  <up>    :echoerr "What are you doing?"<cr>
map  <down>  :echoerr "What are you doing?"<cr>
map  <left>  :echoerr "What are you doing?"<cr>
map  <right> :echoerr "What are you doing?"<cr>

" Change leader key to "space"
let mapleader="\<space>"

" Remove highlights from search with <space>f
map <silent><leader>s :noh<CR>

map <silent><leader>w :w<CR>
map <silent><leader>q :q<cr>
map <silent><leader>x :x<CR>
nnoremap <silent><leader>j <C-W>j
nnoremap <silent><leader>k <C-W>k
nnoremap <silent><leader>l <C-W>l
nnoremap <silent><leader>h <C-W>h
nnoremap <silent><leader>J <C-W>J
nnoremap <silent><leader>K <C-W>K
nnoremap <silent><leader>L <C-W>L
nnoremap <silent><leader>H <C-W>H
nnoremap <silent><leader>W <C-W>W

if &diff
  map <silent><leader>q :qall<CR>
endif

" Escaping insert/visual modes
ino jk <esc>
ino kj <esc>
vno v <esc>
tno jk <C-\><C-n>
tno kj <C-\><C-n>

" Yank whole file
map <leader>y ggyG``

" Go back
nmap <silent>gb :bp<CR>
" Go next
nmap <silent>gn :next<CR>

"{{{ CHAD Tree
nmap <silent><leader>m <cmd>CHADopen<cr>
"}}}

"{{{ Buffer managament
nmap <Leader>b [buffer]

map <silent> [buffer]d :Bdelete<CR>
map <silent> [buffer]D :bd<CR>
map <silent> [buffer]n :bn<CR>
map <silent> [buffer]p :bp<CR>
"}}}

map <Leader>c [cf]
map [cf]n :cnext<CR>
map [cf]p :cprevious<CR>

