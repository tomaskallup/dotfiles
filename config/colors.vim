" Highlight current line number
hi CursorLineNR cterm=bold ctermfg=1

" Ale colors
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" Change colors
hi Directory guifg=#5fff87 ctermfg=3
hi NERDTreeOpenable guifg=#00ff00 ctermfg=12
hi NERDTreeClosable guifg=#af0000 ctermfg=1
hi WarningMsg cterm=bold ctermfg=1 ctermbg=16
hi type ctermfg=10
hi Visual ctermbg=5
hi Special ctermfg=11

" Fix HTML
hi link htmlTag Identifier
hi link htmlTagName statement
hi link htmlEndTag Identifier

" Fix XML colors
hi link xmlTag htmlTag
hi link xmlTagName htmlTagName
hi link xmlEndTag htmlEndTag

" Fix Flow
hi link jsFlowTypeKeyword Keyword

" Fix typescript
hi link typescriptReserved PreProc
hi link typescriptParens Normal
hi link typescriptEndColons Normal
hi link typescriptIdentifier Type
hi link typescriptLabel Type
hi link xmlError Normal
