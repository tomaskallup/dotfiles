"""""""""""""""""""""""""""""""""""
" Custom colors
"""""""""""""""""""""""""""""""""""
hi TabFill ctermbg=232 ctermfg=255
hi TabInactive ctermbg=235 ctermfg=255
hi TabActive ctermbg=240 ctermfg=255
hi TabSeparator ctermfg=232

"""""""""""""""""""""""""""""""""""
" Custom status line
"""""""""""""""""""""""""""""""""""
set statusline=%#Normal#
set statusline+=\  
set statusline+=%#TabFill#
set statusline+= %f%m
set statusline+=%#TabSeparator#
set statusline+=
set statusline+=%#Normal#
set statusline+=%=
set statusline+=%-#TabSeparator#
set statusline+=
set statusline+=%#TabFill#
set statusline+= %l:%c
set statusline+= \| 
set statusline+=%{StatusLineGit()} 

func GitBranch()
    return system("echo ${$(git symbolic-ref HEAD 2>/dev/null)##refs/heads/} | tr -d '\n'")
endfunc

func StatusLineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0 ? l:branchname : '[No Git]'
endfunc

"""""""""""""""""""""""""""""""""""
" Custom tabbar
"""""""""""""""""""""""""""""""""""
set tabline=%!MyTabLine()

function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabActive#'
        else
            let s .= '%#TabInactive#'
        endif

        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabFill#%T'

    return s
endfunction


function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let _ = expand('#'.buflist[winnr - 1].':t')
    return _ !=# '' ? _ : '[No Name]'
endfunction
