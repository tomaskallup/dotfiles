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
let g:rooter_patterns = ['tslint.json', '.vimtags', 'package.json', '.git/']



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     ALE                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'

" Limit ALE linters
let g:ale_linters = {
  \   'html': ['htmlhint'],
  \   'javascript': ['eslint'],
  \   'typescript': ['tsserver', 'tslint'],
  \   'typescriptreact': ['tsserver', 'tslint'],
  \}

let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'typescript': ['tslint']
  \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  YOUCOMPLETEME                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  EASY TAGS                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:easytags_file = '.vimtags'

" Update tags in background and don't interrupt the foreground processes
let g:easytags_async = 1



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
