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
cno jj <c-c>
vno v <esc>

" Fold controll
map <leader>f [fold]
map [fold]o :foldopen<CR>
map [fold]c :foldclose<CR>

" Yank whole file
map <leader>y ggyG``

" Go back
nmap <silent>gb :bp<CR>
" Go next
nmap <silent>gn :next<CR>
"======================================="
"             Plugin mappings           "
"======================================="


"{{{ Coc
nmap <leader>= <Plug>(coc-format)
nmap gd <Plug>(coc-definition)
nmap gi <Plug>(coc-implementation)
nmap <leader>rr <Plug>(coc-references)
nmap <leader>rm <Plug>(coc-rename)
nmap <leader>i <Plug>(coc-codeaction)
nmap <leader>d <Plug>(coc-diagnostic-info)
"nmap <leader>vd :vsp<CR><Plug>(coc-definition)
nmap <silent>gh :call CocActionAsync('doHover')<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
"}}}

"{{{ FZF
nmap <Leader>g [fzf-p]
xmap <Leader>g [fzf-p]

nmap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nmap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nmap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nmap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nmap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nmap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nmap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nmap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nmap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nmap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nmap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
nmap          [fzf-p]gc    :<C-u>CocCommand fzf-preview.ProjectGrep<Space><C-r>=expand('<cword>')<CR>
xmap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nmap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nmap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nmap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>
"}}}


"{{{ Vimspector
nmap <Leader>v [vimspect]
xmap <Leader>v [vimspect]

map [vimspect]c <Plug>VimspectorContinue
map [vimspect]s <Plug>VimspectorStop
map [vimspect]i <Plug>VimspectorStepInto
map [vimspect]o <Plug>VimspectorStepOver
map [vimspect]O <Plug>VimspectorStepOut
map [vimspect]b <Plug>VimspectorToggleBreakpoint
map [vimspect]B <Plug>VimspectorToggleConditionalBreakpoint
map <silent>[vimspect]r :<C-u>VimspectorReset<CR>
"}}}

"{{{ Coc explorer
nmap <silent><leader>m :<C-u>CocCommand explorer<CR>
"}}}

"{{{ CHAD Tree
nmap <silent><leader>m <cmd>CHADopen<cr>
"}}}

"{{{ Completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"inoremap <silent><expr> <CR>      compe#confirm('<CR>', 'i')
"inoremap <silent><expr> <C-y>      compe#confirm('<C-y>', 'i')
"}}}
