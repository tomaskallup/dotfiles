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
"set statusline=%#Normal#
"set statusline+=\  
"set statusline+=%#TabFill#
"set statusline+= %f%m
"set statusline+=%#TabSeparator#
"set statusline+=
"set statusline+=%#Normal#
"set statusline+=%=
"set statusline+=%-#TabSeparator#
"set statusline+=
"set statusline+=%#TabFill#
"set statusline+= %l:%c
"set statusline+= \| 
"set statusline+=%{StatusLineGit()} 
"set statusline+=%#Normal#

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
"set tabline=%!MyTabLine()

fun MyTabLine()

    let screen_width = &columns - 2
    let text_width = 0

    let on_screen = tabpagebuflist()

    let names = []
    let cur = bufnr('%')
    for i in range(1, bufnr('$'))

        if !s:IsVisible(i)
            continue
        endif

        let name = s:TabLabel(i)

        let synname = 'TabInactive'
        if cur == i
            let synname = 'TabActive'
        elseif index(on_screen, i) >= 0
            let synname = 'TabFill'
        endif

        let names += [{'text': name, 'syn': synname}]
        let text_width += strlen(name)

        if cur < i - 1
            if text_width > screen_width
                let dif = text_width - screen_width
                let names[-1]['text'] = names[-1]['text'][: -dif]
                let text_width -= strlen(dif)

                break
            endif
        else
            while text_width > screen_width
                let dif = text_width - screen_width
                let first = names[0]
                if strlen(first['text']) <= dif
                    call remove(names, 0)
                    let text_width -= strlen(first['text'])
                else
                    let first['text'] = first['text'][dif :]
                    let text_width -= dif
                endif
            endwhile
        endif
    endfor

    let rst = ''
    for elt in names
        let rst .= '%#' . elt['syn'] . '#' . elt['text'] . '%#TabFill#'
    endfor

    return rst
endfunction

fun! s:IsVisible(i)
    if !bufexists(a:i) || !buflisted(a:i)
        return 0
    endif

    if getbufvar(a:i, 'current_syntax') == 'qf'
        return 0
    endif

    return 1
endfunction

fun! s:TabLabel(i)
    let mod = getbufvar(a:i, "&mod")
    let text = ""

    if mod == 1
        let text = "[+]"
    endif

    return s:BufLabel(a:i) . text
endfunction

fun! s:BufLabel(i)
    let path = bufname(a:i)
    if path == ""
        return ' [No Name] '
    endif

    let path = s:PathForHuman(path)
    return substitute(' {path} ', '\V{path}', path, 'g')

endfunction

fun! s:PathForHuman(p)
    let p = a:p
    let p = simplify(p)
    let p = substitute(p, '\', '/', 'g')

    let p = substitute(p, '^\V' . escape( $HOME, '\' ), '~', '')

    let p = pathshorten(p)
    return p
endfunction
