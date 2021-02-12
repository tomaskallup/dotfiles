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

" Yank whole file
map <leader>y ggyG``

" Go back
nmap <silent>gb :bp<CR>
" Go next
nmap <silent>gn :next<CR>
"======================================="
"             Plugin mappings           "
"======================================="

"{{{ FZF
"nmap <Leader>f [fzf-p]
"xmap <Leader>f [fzf-p]

"nnoremap <silent> [fzf-p]p     :<C-u>FzfPreviewFromResources project_mru git<CR>
"nnoremap <silent> [fzf-p]gs    :<C-u>FzfPreviewGitStatus<CR>
"nnoremap <silent> [fzf-p]ga    :<C-u>FzfPreviewGitActions<CR>
"nnoremap <silent> [fzf-p]b     :<C-u>FzfPreviewBuffers<CR>
"nnoremap <silent> [fzf-p]B     :<C-u>FzfPreviewAllBuffers<CR>
"nnoremap <silent> [fzf-p]o     :<C-u>FzfPreviewFromResources buffer project_mru<CR>
"nnoremap <silent> [fzf-p]<C-o> :<C-u>FzfPreviewJumps<CR>
"nnoremap <silent> [fzf-p]g;    :<C-u>FzfPreviewChanges<CR>
"nnoremap <silent> [fzf-p]/     :<C-u>FzfPreviewLines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
"nnoremap <silent> [fzf-p]*     :<C-u>FzfPreviewLines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
"nnoremap          [fzf-p]gr    :<C-u>FzfPreviewProjectGrep<Space>
"nmap              [fzf-p]gc    :<C-u>FzfPreviewProjectGrep<Space><C-r>=expand('<cword>')<CR>
"xnoremap          [fzf-p]gr    "sy:FzfPreviewProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
"nnoremap <silent> [fzf-p]t     :<C-u>FzfPreviewBufferTags<CR>
"nnoremap <silent> [fzf-p]q     :<C-u>FzfPreviewQuickFix<CR>
"nnoremap <silent> [fzf-p]l     :<C-u>FzfPreviewLocationList<CR>
"}}}

"{{{ Telescope
nmap <Leader>f [telescope]
xmap <Leader>f [telescope]

nnoremap [telescope]f <cmd>Telescope find_files theme=get_dropdown<cr>
nnoremap [telescope]g <cmd>Telescope live_grep theme=get_dropdown<cr>
nnoremap [telescope]b <cmd>Telescope buffers theme=get_dropdown<cr>
nnoremap [telescope]h <cmd>Telescope help_tags<cr>
nnoremap [telescope]r <cmd>Telescope lsp_references<cr>
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

"{{{ CHAD Tree
nmap <silent><leader>m <cmd>CHADopen<cr>
"}}}

"{{{ Completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"inoremap <silent><expr> <CR>      compe#confirm('<CR>', 'i')
inoremap <silent><expr> <C-y>      compe#confirm('<C-y>', 'i')
"}}}

"{{{ Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"}}}
