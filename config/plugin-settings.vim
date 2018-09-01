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
"                 LIGHT LINE                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
    \ 'colorscheme': 'zupa',
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename' ] ],
    \   'right': [ [ 'fileformat', 'fileencoding', 'filetype' ], [ 'lineinfo' ], ['linter_warnings', 'linter_errors', 'linter_ok'] ]
    \ },
    \ 'component_expand': {
    \   'linter_warnings': 'LightlineLinterWarnings',
    \   'linter_errors': 'LightlineLinterErrors',
    \   'linter_ok': 'LightlineLinterOK'
    \ },
    \ 'component_function': {
    \   'modified': 'LightlineModified',
    \   'readonly': 'LightlineReadonly',
    \   'fugitive': 'LightlineFugitive',
    \   'filename': 'LightlineFilename',
    \   'fileformat': 'LightlineFileformat',
    \   'filetype': 'LightlineFiletype',
    \   'fileencoding': 'LightlineFileencoding',
    \   'mode': 'LightlineMode',
    \ },
    \ 'component_type': {
    \   'linter_warning': 'warning',
    \   'linter_errors': 'error',
    \ }
    \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  COMPLETOR                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:completor_node_binary = '/usr/local/bin/node'
let g:completor_css_omni_trigger = '([\w-]+|@[\w-]*|[\w-]+:\s*[\w-]*)$'



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
