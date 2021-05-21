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

"{{{ Execution
nmap <Leader>R [run]
vmap <Leader>R [run]

nnoremap <silent> [run]t :TerminatorOpenTerminal <CR>
nnoremap <silent> [run]r :TerminatorStartREPL <CR>
nnoremap <silent> [run]f :TerminatorRunFileInTerminal <CR>
nnoremap <silent> [run]F :TerminatorRunFileInOutputBuffer <CR>
nnoremap <silent> [run]s :TerminatorStopRun <CR>

nnoremap <silent> [run]d :call terminator#send_delimiter_to_terminal()<CR>
vnoremap <silent> [run]t :<C-U> call terminator#send_to_terminal(terminator#get_visual_selection())<CR>

vnoremap <silent> [run]f :<C-U> call terminator#run_part_of_file("output_buffer", terminator#get_visual_selection())<CR>
vnoremap <silent> [run]F :<C-U> call terminator#run_part_of_file("terminal", terminator#get_visual_selection())<CR>
"}}}

