" Better Visual highlight
hi Visual term=inverse ctermbg=247 ctermfg=NONE

" Highlight current line number
hi CursorLineNR cterm=bold ctermfg=1

" Fix HTML
hi link htmlTag Identifier
hi link htmlTagName statement
hi link htmlEndTag Identifier

" Fix typescript
hi link tsxTagName htmlTagName
hi link typescriptTypeReference Type
hi link typescriptInterfaceName Type
hi link typescriptAliasDeclaration Type
hi link typescriptObjectLabel SpecialKey
hi link typescriptMember typescriptObjectLabel
hi link typescriptPredefinedType Type
hi link typescriptVariable Keyword
hi link typescriptOperator Keyword
hi link typescriptEnum Type
hi link typescriptEnumKeyword Keyword
hi link typescriptDestructureVariable Normal
hi link typescriptDestructureLabel SpecialKey
hi link typescriptBraces PreProc
hi link typescriptArrowFuncArg Identifier
hi link typescriptCall Identifier

" Fix CoC
hi CocUnderline ctermbg=52 cterm=none gui=none
hi CocFloating ctermbg=black ctermfg=yellow
hi CocInfoFloat ctermfg=red
hi CocErrorSign ctermfg=160

" Fix SpellBad for strings etc.
hi SpellBad ctermbg=9 gui=undercurl guisp=Red ctermfg=white
