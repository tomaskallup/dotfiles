" Disable arrow keys
map  <up>    :echoerr "What are you doing?"<cr>
map  <down>  :echoerr "What are you doing?"<cr>
map  <left>  :echoerr "What are you doing?"<cr>
map  <right> :echoerr "What are you doing?"<cr>

" Change leader key to "space"
let mapleader="\<space>"

" Setup custom shortcuts
map K gt
map J gT
" Remove highlights from search with <space>f
map <leader>f :noh<CR>

map <leader>w :w<CR>
map <leader>q :q<cr>
map <leader>Q :qall<CR>
map <leader>x :x<CR>
map <leader>X :xall<CR>
map <leader>n :tabnew<CR>
map <leader>b :CtrlPBuffer<CR>
"map <leader>h :LspHover<CR>
"map <leader>rr :LspReferences<CR>
"map <leader>rn :LspNextReference<CR>

map <leader>ad :ALEDetail<CR>
map <leader>af :ALEFix<CR>

" Session saving
map <leader>ss :mksession! ~/.vim_session<CR>
map <leader>sl :source ~/.vim_session<CR>

" Terminal in vim
map <leader>t :terminal<CR>

ino jk <esc>
ino kj <esc>
cno jj <c-c>
vno v <esc>

" Reindent whole file and go back to curosr
" map <leader>= gg=G``
" Repalced with coc formatter
map <silent><leader>= :CocCommand prettier.formatFile<CR>

" Copy whole file and go back to curosr
map <leader>y ggyG``

nmap , <Plug>(easymotion-overwin-f)
nmap , <Plug>(easymotion-overwin-f2)

" Leader + q closes all windows in diffmode
if &diff
    map <leader>q :qall<CR>
endif

nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
nnoremap <leader>h <C-W>h
nnoremap <leader>J <C-W>J
nnoremap <leader>K <C-W>K
nnoremap <leader>L <C-W>L
nnoremap <leader>H <C-W>H
nnoremap <leader>p <C-W>p

nnoremap <silent><leader>vp :vsp \| bp<CR>
nnoremap <silent><leader>vn :vsp \| bn<CR>
nnoremap <silent><leader>vd :vsp \| call CocActionAsync('jumpDefinition')<CR>

" NERDtree settings
map <C-n> :NERDTreeFind<CR>
map m :NERDTreeToggle<CR>
let NERDTreeMapActivateNode='l'
let NERDTreeMapCloseChildren='h'

" Go back
nmap <silent> gb :bp<CR>
" Go next
nmap <silent> gn :next<CR>

" LSP
"nmap <silent> gd :LspDefinition<CR>
"nmap <silent> gi :LspImplementation<CR>
"nmap <silent> gr :LspReferences<CR>
"nmap <leader>i :LspCodeAction<CR>

" CoC
nmap  gd <Plug>(coc-definition)
nmap  gi <Plug>(coc-implementation)
nmap <leader>r <Plug>(coc-references)
nmap <leader>m <Plug>(coc-rename)
nmap <leader>i <Plug>(coc-codeaction)
nmap <leader>d <Plug>(coc-diagnostic-info)
nmap <leader>vd :vsp<CR><Plug>(coc-definition)
nmap <silent> gh :call CocAction('doHover')<CR>

" use <tab> for trigger completion and navigate next complete item
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" use <cr> to confirm completion (for autoimporting etc)
"inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<cr>"

" Asyncomplete
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
