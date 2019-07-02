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
hi Special ctermfg=11
hi Search ctermbg=2 ctermfg=0

" Fix HTML
hi link htmlTag Identifier
hi link htmlTagName statement
hi link htmlEndTag Identifier

" Fix XML colors
hi link xmlTag htmlTag
hi link xmlTagName htmlTagName
hi link xmlEndTag htmlEndTag

" Fix typescript
hi link tsxTagName htmlTagName
hi link typescriptTypeReference Type
hi link typescriptInterfaceName typescriptTypeReference
hi link typescriptAliasDeclaration typescriptTypeReference
hi link typescriptObjectLabel specialkey
hi link typescriptMember typescriptObjectLabel
hi link typescriptPredefinedType typescriptTypeReference
hi link typescriptVariable keyword
hi link typescriptOperator keyword
hi link typescriptEnum typescriptInterfaceName
hi link typescriptEnumKeyword Keyword

" Fix javascript
hi link javascriptObjectLabel specialkey
hi link javascriptVariable keyword
hi link javascriptExport keyword
hi link jsxAttrib type
hi link javascriptArrowFuncArg PreProc
hi link jsClassDefinition cleared
hi link jsObjectKey specialkey
hi link jsFunctionKey specialkey
hi link jsObjectFuncName specialkey
hi link jsClassFuncName specialkey
hi link jsFuncCall cleared
hi link jsThis Type
hi link jsSuper Type
hi link jsOperator cleared
hi link jsFuncArgs specialkey
hi link jsStorageClass keyword
hi link jsImport keyword
hi link jsFrom keyword
hi link jsExport keyword
hi link jsExportDefault keyword
hi link jsModuleAs keyword
hi link jsOperatorKeyword keyword

" Fix SpellBad for strings etc.
hi SpellBad ctermbg=9 gui=undercurl guisp=Red ctermfg=white

" Fix LSP reference
hi lspReference ctermfg=white ctermbg=240

" Fix CoC
hi CocUnderline ctermbg=52 cterm=none gui=none
hi CocFloating ctermbg=black ctermfg=yellow
hi CocInfoFloat ctermfg=red
hi CocErrorSign ctermfg=160
