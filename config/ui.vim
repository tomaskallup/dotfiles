"""""""""""""""""""""""""""""""""""
" Custom status line
"""""""""""""""""""""""""""""""""""
set statusline=%#Normal#
set statusline+=  
set statusline+=%#PMenu#
set statusline+= %f%m
set statusline+=%#Constant#
set statusline+=
set statusline+=%#Normal#
set statusline+=%=
set statusline+=%-#Constant#
set statusline+=
set statusline+=%#Pmenu#
set statusline+= %l:%c 
set statusline+=%{GitBranch()} 

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

"""""""""""""""""""""""""""""""""""
" Custom tabbar
"""""""""""""""""""""""""""""""""""
set tabline=%!MyTabLine()

function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#PMenu#'
        else
            let s .= '%#PMenuSel#'
        endif

        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#Normal#%T'

    return s
endfunction

function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let name = bufname(buflist[winnr - 1])

    if len(name) == 0
        let name = '[No name]'
    endif

    return name
endfunction
