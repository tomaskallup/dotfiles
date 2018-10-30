"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  EASY MOTION                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn on smart case feature for EasyMotion
let g:EasyMotion_smartcase = 1

" Disable default key-mappings
" Custom ones are defined in keymap.vim
let g:EasyMotion_do_mapping = 0



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   NERD TREE                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen = 1

" Close vim if nerdtree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    ROOTER                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rooter_patterns = ['tsconfig.json', 'jsconfig.json', '.git/', 'package.json']
"let g:rooter_targets = '/,tsconfig.json,jsconfig.json,tslint.json,.vimtags,package.json'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     ALE                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'

" Limit ALE linters
let g:ale_linters = {
  \   'html': ['htmlhint'],
  \   'javascript': ['eslint'],
  \   'typescript': ['stylelint', 'tslint'],
  \}

let g:ale_linter_aliases = {
  \ 'tsx': 'css'
  \}

let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'typescript': ['tsserver', 'tslint']
  \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  YOUCOMPLETEME                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion = 1



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   STARTIFY                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:startify_fortune_use_unicode = 1



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
let g:ctrlp_clear_cache_on_exit = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      YATS                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:yats_host_keyword = 0
