"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   NERD TREE                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen = 1

" Close vim if nerdtree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "A",
    \ "Untracked" : "?",
    \ "Renamed"   : "R",
    \ "Unmerged"  : "U",
    \ "Deleted"   : "D",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : 'I',
    \ "Unknown"   : "?"
    \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    ROOTER                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rooter_patterns = ['.venv', '.git/', '.vim/']
"let g:rooter_patterns = ['tsconfig.json', 'jsconfig.json', '.venv', 'requirements.txt', '.git/', 'package.json']
"let g:rooter_targets = '/,tsconfig.json,jsconfig.json,tslint.json,.vimtags,package.json'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     ALE                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_warning = '⚠'
let g:ale_sign_error = '✗'

" Limit ALE linters
let g:ale_linters = {
  \   'html': ['htmlhint'],
  \   'javascript': ['eslint'],
  \   'typescript': ['eslint'],
  \}

let g:ale_linter_aliases = {
  \ 'tsx': 'css'
  \}

let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'typescript': []
  \}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   VIM JSON                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_json_syntax_conceal = 0



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    VIM JSX                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    MATCH IT                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fix HTML
autocmd FileType html let b:match_words='<:>,<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     CTRL P                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_clear_cache_on_exit = 1

let g:ctrlp_user_command = 'git ls-files . --exclude-standard'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      YATS                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:yats_host_keyword = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       ACK                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     MARKDOWN                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'typescript', 'typescript.tsx=typescript', 'scss=css', 'typescriptreact=typescript']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       LSP                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx'],
        \ })

    au User lsp_setup call lsp#register_server({
        \ 'name': 'javascript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'jsconfig.json'))},
        \ 'whitelist': ['javascript', 'javascript.jsx'],
        \ })
endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       COC                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_filetype_map = {
  \ 'sass': 'scss',
  \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     VIMSPECTOR                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimspector_enable_mappings = 'HUMAN'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    ASYNCOMPLETE                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

"call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    "\ 'name': 'buffer',
    "\ 'whitelist': ['*'],
    "\ 'blacklist': ['go'],
    "\ 'priority': -1,
    "\ 'completor': function('asyncomplete#sources#buffer#completor'),
    "\ }))
